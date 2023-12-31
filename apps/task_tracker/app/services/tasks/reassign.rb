module Tasks
  class Reassign
    include Dry::Monads[:result]

    def initialize(send_event: Events::Send.new)
      @_send_event = send_event
    end

    # @param identity_id [Integer]
    #
    # @return [Task]
    #
    def call(identity_id:)
      employee = Employee.find_by!(identity_id:)
      return Failure(:unauthorized) unless employee.manager? || employee.admin?

      ActiveRecord::Base.transaction do
        Task.in_progress.find_each do |task|
          reassign(task)
          publish_event(task)
        end
      end

      Success()
    end

    private

    attr_reader :_send_event

    def reassign(task)
      task.update!(assignee: select_assignee, assigned_at: Time.current)
    end

    def select_assignee
      Employee.developer.order("RANDOM()").first
    end

    def publish_event(task)
      event = Events::Tasks::Assigned::V1.new(
        public_id: task.public_id,
        assignee_public_id: task.assignee.public_id,
        assigned_at: task.assigned_at.iso8601
      )

      _send_event.call(event:)
    end
  end
end
