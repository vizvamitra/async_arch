module Facts
  class TaskCompletionRewardPaidFact < ApplicationRecord
    belongs_to :date, class_name: "Dimensions::Date"
    belongs_to :employee, class_name: "Dimensions::Employee", optional: true
    belongs_to :task, class_name: "Dimensions::Task"
  end
end
