module Events
  class TaskCreated < Event
    topic "streaming.tasks"

    attribute :public_id, Types::String
    attribute :title, Types::String
    attribute :description, Types::String
    attribute :assignee_id, Types::Integer
    attribute :assignment_fee, Types::Integer
    attribute :completion_reward, Types::Integer
    attribute :created_at, Types::Integer
  end
end
