module Dimensions
  class Date < ApplicationRecord
    has_many :task_completion_reward_paid_facts, class_name: "Facts::TaskCompletionRewardPaidFact"
    has_many :account_balance_changed_facts, class_name: "Facts::AccountBalanceChangedFact"
  end
end
