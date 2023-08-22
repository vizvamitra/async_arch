module Events
  module Tasks
    module Completed
      class V1 < Event
        event_type "tasks/completed"
        event_name "TaskCompleted"
        event_version 1

        attribute :public_id, Types::String
        attribute :assignee_public_id, Types::String
        attribute :completed_at, Types::String
      end
    end
  end
end
