module Events
  module Accounts
    module BalanceChanged
      class V1 < Event
        event_type "accounts/balance_changed"
        event_name "AccountBalanceChanged"
        event_version 1

        attribute :account_public_id, Types::String
        attribute :balance, Types::Integer
        attribute :changed_at, Types::String
      end
    end
  end
end
