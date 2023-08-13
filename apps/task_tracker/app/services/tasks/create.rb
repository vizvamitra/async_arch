module Tasks
  class Create
    include Dry::Monads[:result]

    ASSIGNMENT_FEE_RANGE = 10..20
    COMPLETION_REWARD_RANGE = 20..40

    def initialize(send_event: Events::Send.new)
      @send_event = send_event
    end

    # @param description [String]
    #
    # @return [Task]
    #
    def call(description:)
      task = create_task(description)
      publish_event(task.reload)

      Success(task)
    end

    private

    attr_reader :send_event

    def create_task(description)
      Task.create!(
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
      event = Events::Streaming::TaskCreated.new(
        public_id: task.public_id,
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
