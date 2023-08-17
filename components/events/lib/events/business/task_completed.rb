module Events
  module Business
    class TaskCompleted < Event
      topic "task_lifecycle"

      attribute :public_id, Types::String
      attribute :assignee_public_id, Types::String
      attribute :completed_at, Types::Integer
    end
  end
end
