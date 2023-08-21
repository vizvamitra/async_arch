module Events
  module Accounts
    module BalanceChanged
      class V2 < Event
        event_type "accounts/balance_changed"
        event_name "AccountBalanceChanged"
        event_version 2

        attribute :account_public_id, Types::String
        attribute :owner_public_id, Types::String.optional
        attribute :balance, Types::Integer
        attribute :changed_at, Types::String
      end
    end
  end
end
