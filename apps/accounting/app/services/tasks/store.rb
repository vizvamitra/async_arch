module Tasks
  class Store
    ASSIGNMENT_FEE_RANGE = 10..20
    COMPLETION_REWARD_RANGE = 20..40

    # @param public_id [String]
    # @param title [String]
    # @param jira_id [String]
    #
    # @return [Task]
    #
    def call(public_id:, **attributes)
      task = find_or_build_task(public_id)
      sync(task, attributes)

      task
    rescue ActiveRecord::RecordNotUnique
      retry
    end

    private

    attr_reader :_create_account

    def find_or_build_task(public_id)
      Task
        .create_with(
          assignment_fee: rand(ASSIGNMENT_FEE_RANGE),
          completion_reward: rand(COMPLETION_REWARD_RANGE)
        )
        .find_or_initialize_by(public_id:)
    end

    def sync(task, attributes)
      task.update!(
        title: attributes[:title] || task.title,
        jira_id: attributes[:jira_id] || task.jira_id
      )
    end
  end
end
