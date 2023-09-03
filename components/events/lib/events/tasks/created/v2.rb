module Events
  module Tasks
    module Created
      class V2 < Event
        event_type "tasks/created"
        event_name "TaskCreated"
        event_version 2

        attribute :public_id, Types::String
        attribute :title, Types::String
        attribute :jira_id, Types::String.optional
        attribute :assignee_public_id, Types::String
        attribute :created_at, Types::String
      end
    end
  end
end
