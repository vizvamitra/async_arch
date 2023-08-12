module Tasks
  class Create
    include Dry::Monads[:result]

    ASSIGNMENT_FEE_RANGE = 10..20
    COMPLETION_REWARD_RANGE = 20..40

    def initialize(send_event: Events::Send.new)
      @send_event = send_event
    end

    # @param title [String]
    # @param description [String]
    #
    # @return [Task]
    #
    def call(title:, description:)
      task = create_task(title, description)
      publish_event(task.reload)

      Success(task)
    end

    private

    attr_reader :send_event

    def create_task(title, description)
      Task.create!(
        title:,
        description:,
        assignee: select_assignee,
        assigned_at: Time.current,
        assignment_fee: rand(ASSIGNMENT_FEE_RANGE),
        completion_reward: rand(COMPLETION_REWARD_RANGE)
      )
    end

    def select_assignee
      Auth::User.developer.order("RANDOM()").first
    end

    def publish_event(task)
      event = Events::TaskCreated.new(
        public_id: task.public_id,
        title: task.title,
        description: task.description,
        assignee_id: task.assignee_id,
        assignment_fee: task.assignment_fee,
        completion_reward: task.completion_reward,
        created_at: task.created_at.to_i
      )

      send_event.call(event:)
    end
  end
end
