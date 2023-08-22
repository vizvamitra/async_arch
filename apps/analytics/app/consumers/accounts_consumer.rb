# frozen_string_literal: true

class AccountsConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      event_data = message.payload["data"].symbolize_keys

      case message.payload["event_name"]
      when "AccountCreated"
        Dimensions::Accounts::Store.new.call(
          public_id: event_data[:public_id],
          category: event_data[:category],
          owner_public_id: event_data[:owner_public_id]
        )
      when "AccountBalanceChanged"
        Facts::AccountBalanceChanged::Store.new.call(
          account_public_id: event_data[:account_public_id],
          owner_public_id: event_data[:owner_public_id],
          balance: event_data[:balance],
          changed_at: event_data[:changed_at]
        )
      end
    end
  end

  # def revoked
  # end

  # def shutdown
  # end
end
