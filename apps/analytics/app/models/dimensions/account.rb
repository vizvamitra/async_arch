module Dimensions
  class Account < ApplicationRecord
    enum category: {
      asset: 1,
      liability: 2,
      equity: 3,
      revenue: 4,
      expense: 5,
      temporary: 6
    }

    has_many :account_balance_changed_facts, class_name: "Facts::AccountBalanceChangedFact"
  end
end
