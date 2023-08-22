module Facts
  class AccountBalanceChangedFact < ApplicationRecord
    belongs_to :date, class_name: "Dimensions::Date"
    belongs_to :employee, class_name: "Dimensions::Employee", optional: true
    belongs_to :account, class_name: "Dimensions::Account"
  end
end
