module Dimensions
  class Employee < ApplicationRecord
    enum role: { developer: 0, manager: 1, accountant: 2, admin: 3 }

    has_many :task_completion_reward_paid_facts, class_name: "Facts::TaskCompletionRewardPaidFact"
    has_many :account_balance_changed_facts, class_name: "Facts::AccountBalanceChangedFact"
  end
end
