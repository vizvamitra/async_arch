module Events
  module Business
    class TaskCompleted < Event
      topic "tasks"

      attribute :public_id, Types::String
      attribute :assignee_id, Types::Integer
      attribute :completed_at, Types::Integer
    end
  end
end
