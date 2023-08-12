module Tasks
  class Reassign
    include Dry::Monads[:result]

    def initialize(send_event: Events::Send.new)
      @send_event = send_event
    end

    # @param title [String]
    # @param description [String]
    #
    # @return [Task]
    #
    def call(user_id:)
      user = Auth::User.find(user_id)
      return Failure(:unauthorized) unless ["manager", "admin"].include?(user.role)

      Task.in_progress.find_each do |task|
        reassign(task)
        publish_event(task)
      end

      Success()
    end

    private

    attr_reader :send_event

    def reassign(task)
      task.update!(assignee: select_assignee, assigned_at: Time.current)
    end

    def select_assignee
      Auth::User.developer.order("RANDOM()").first
    end

    def publish_event(task)
      event = Events::TaskAssigned.new(
        public_id: task.public_id,
        assignee_id: task.assignee_id,
        assigned_at: task.assigned_at.to_i
      )

      send_event.call(event:)
    end
  end
end
