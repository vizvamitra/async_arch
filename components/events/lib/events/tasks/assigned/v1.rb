module Events
  module Tasks
    module Assigned
      class V1 < Event
        event_type "tasks/assigned"
        event_name "TaskAssigned"
        event_version 1

        attribute :public_id, Types::String
        attribute :assignee_public_id, Types::String
        attribute :assigned_at, Types::String
      end
    end
  end
end
