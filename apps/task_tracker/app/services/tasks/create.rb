module Tasks
  class Create
    include Dry::Monads[:result]

    ASSIGNMENT_FEE_RANGE = 10..20
    COMPLETION_REWARD_RANGE = 20..40

    def initialize(send_events: Events::SendBatch.new)
      @_send_events = send_events
    end

    # @param description [String]
    #
    # @return [Task]
    #
    def call(description:)
      task = create_task(description)
      publish_events(task.reload)

      Success(task)
    end

    private

    attr_reader :_send_events

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
      Employee.developer.order("RANDOM()").first
    end

    def publish_events(task)
      events = [
        streaming_event(task),
        assigned_event(task)
      ]

      _send_events.call(events:)
    end

    def streaming_event(task)
      Events::Tasks::Created::V1.new(
        public_id: task.public_id,
        description: task.description,
        assignee_public_id: task.assignee.public_id,
        assignment_fee: task.assignment_fee,
        completion_reward: task.completion_reward,
        created_at: task.created_at.iso8601
      )
    end

    def assigned_event(task)
      Events::Tasks::Assigned::V1.new(
        public_id: task.public_id,
        assignee_public_id: task.assignee.public_id,
        assigned_at: task.assigned_at.iso8601
      )
    end
  end
end
