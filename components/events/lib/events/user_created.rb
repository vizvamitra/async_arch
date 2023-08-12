module Events
  class UserCreated < Event
    topic "streaming.users"

    attribute :public_id, Types::String
    attribute :email, Types::String
    attribute :role, Types::String
    attribute :first_name, Types::String
    attribute :last_name, Types::String
    attribute :created_at, Types::Integer
  end
end
