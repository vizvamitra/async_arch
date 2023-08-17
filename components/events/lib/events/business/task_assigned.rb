module Events
  module Business
    class TaskAssigned < Event
      topic "task_lifecycle"

      attribute :public_id, Types::String
      attribute :assignee_public_id, Types::String
      attribute :assigned_at, Types::Integer
    end
  end
end
