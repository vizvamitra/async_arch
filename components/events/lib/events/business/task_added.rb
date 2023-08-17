module Events
  module Business
    class TaskAdded < Event
      topic "task_lifecycle"

      attribute :public_id, Types::String
      attribute :description, Types::String
      attribute :assignee_public_id, Types::String
      attribute :assignment_fee, Types::Integer
      attribute :completion_reward, Types::Integer
      attribute :created_at, Types::Integer
    end
  end
end
