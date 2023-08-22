module Dimensions
  class Task < ApplicationRecord
    has_many :task_completion_reward_paid_facts, class_name: "Facts::TaskCompletionRewardPaidFact"
  end
end
