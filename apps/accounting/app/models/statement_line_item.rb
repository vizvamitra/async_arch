class StatementLineItem < ApplicationRecord
  enum section: { revenues: 0, expenses: 1, net_income: 2 }

  belongs_to :statement, class_name: "FinancialStatement"
end
