module Tasks
  class Complete
    include Dry::Monads[:result]

    def initialize(send_event: Events::Send.new)
      @send_event = send_event
    end

    # @param identity_id [Integer]
    # @param task_id [Integer]
    #
    # @return [Task]
    # @raise [ActiveRecord::RecordNotFound]
    #
    def call(identity_id:, task_id:)
      employee = Employee.find_by!(identity_id:)
      return Failure(:unauthorized) unless employee.developer?

      task = Task.where(assignee: employee).find(task_id)

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
        assignee_public_id: task.assignee.public_id,
        completed_at: task.completed_at.to_i
      )

      send_event.call(event:)
    end
  end
end
