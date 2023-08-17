module Auth
  class Info < Dry::Struct
    attribute :public_id, Types::String
    attribute :email, Types::String
    attribute :role, Types::String
    attribute :first_name, Types::String
    attribute :last_name, Types::String
  end
end
