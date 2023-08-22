# frozen_string_literal: true

class TasksConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      event_data = message.payload["data"].symbolize_keys

      case message.payload["event_name"]
      when "TaskCreated"
        Dimensions::Tasks::Store.new.call(
          public_id: event_data[:public_id],
          title: event_data[:title],
          jira_id: event_data[:jira_id]
        )
      end
    end
  end

  # def revoked
  # end

  # def shutdown
  # end
end
