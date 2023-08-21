module Events
  module Transactions
    module TaskCompletionRewardPaid
      class V1 < Event
        event_type "transactions/task_completion_reward_paid"
        event_name "TaskCompletionRewardPaid"
        event_version 1

        attribute :task_public_id, Types::String
        attribute :employee_public_id, Types::String
        attribute :amount, Types::Integer
        attribute :paid_at, Types::String
      end
    end
  end
end
