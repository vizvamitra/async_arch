# frozen_string_literal: true

class EmployeesConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      event_data = message.payload["data"].symbolize_keys

      case message.payload["event_name"]
      when "EmployeeCreated"
        Dimensions::Employees::Store.new.call(
          public_id: event_data[:public_id],
          role: event_data[:role],
          email: event_data[:email],
          first_name: event_data[:first_name],
          last_name: event_data[:last_name]
        )
      end
    end
  end

  # def revoked
  # end

  # def shutdown
  # end
end
