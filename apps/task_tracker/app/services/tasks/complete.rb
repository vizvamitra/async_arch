module Tasks
  class Complete
    include Dry::Monads[:result]

    def initialize(send_event: Events::Send.new)
      @send_event = send_event
    end

    # @param user_id [Integer]
    # @param task_id [Integer]
    #
    # @return [Task]
    # @raise [ActiveRecord::RecordNotFound]
    #
    def call(user_id:, task_id:)
      user = Auth::User.find(user_id)
      return Failure(:unauthorized) unless user.developer?

      task = Task.where(assignee: user).find(task_id)

      task.update!(status: :completed, completed_at: Time.current)
      publish_event(task)

      Success(task)
    end

    private

    attr_reader :send_event

    def complete(task)
      task.update!(status: :completed, completed_at: Time.current)
    end

    def publish_event(task)
      event = Events::Business::TaskCompleted.new(
        public_id: task.public_id,
        assignee_id: task.assignee_id,
        completed_at: task.completed_at.to_i
      )

      send_event.call(event:)
    end
  end
end
