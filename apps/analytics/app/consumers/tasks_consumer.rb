# frozen_string_literal: true

class TasksConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      event_data = message.payload["data"].symbolize_keys

      case message.payload["event_name"]
      when "TaskCreated"
        case message.payload["event_version"]
        when 1
          Dimensions::Tasks::StoreV1.new.call(
            public_id: event_data[:public_id],
            description: event_data[:description]
          )
        when 2
          Dimensions::Tasks::Store.new.call(
            public_id: event_data[:public_id],
            title: event_data[:title],
            jira_id: event_data[:jira_id]
          )
        end
      end
    end
  end

  # def revoked
  # end

  # def shutdown
  # end
end
