module Events
  module Accounts
    module Created
      class V2 < Event
        event_type "accounts/created"
        event_name "AccountCreated"
        event_version 2

        attribute :public_id, Types::String
        attribute :owner_public_id, Types::String.optional
        attribute :number, Types::Integer
        attribute :category, Types::String
        attribute :name, Types::String
        attribute :contra, Types::Bool
        attribute :created_at, Types::String
      end
    end
  end
end
