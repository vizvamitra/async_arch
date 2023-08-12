module Events
  class TaskAssigned < Event
    topic "tasks"

    attribute :public_id, Types::String
    attribute :assignee_id, Types::Integer
    attribute :assigned_at, Types::Integer
  end
end
