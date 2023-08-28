# frozen_string_literal: true

class TasksConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      event_data = message.payload["data"].symbolize_keys

      case message.payload["event_name"]
      when "TaskCreated"
        case message.payload["event_version"]
        when 1 then Tasks::StoreV1.new.call(**event_data)
        when 2 then Tasks::Store.new.call(**event_data)
        end
      when "TaskAssigned"
        Tasks::HandleAssignment.new.call(
          task_public_id: event_data[:public_id],
          assignee_public_id: event_data[:assignee_public_id]
        )
      when "TaskCompleted"
        Tasks::HandleCompletion.new.call(
          task_public_id: event_data[:public_id],
          assignee_public_id: event_data[:assignee_public_id]
        )
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
