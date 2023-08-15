# frozen_string_literal: true

# Example consumer that prints messages payloads
class UsersConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      case message.payload["type"]
      when "UserCreated"
        Users::Create.new.call(**message.payload["data"].symbolize_keys)
      end
    end
  end

  # Run anything upon partition being revoked
  # def revoked
  # end

  # Define here any teardown things you want when Karafka server stops
  # def shutdown
  # end
end
