# frozen_string_literal: true

class TransactionsConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      event_data = message.payload["data"].symbolize_keys

      case message.payload["event_name"]
      when "TaskCompletionRedardPaid"
        Facts::TaskCompletionRewardPaid::Store.new.call(**event_data)
      end
    end
  end

  # def revoked
  # end

  # def shutdown
  # end
end
