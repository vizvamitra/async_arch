class FinancialStatement < ApplicationRecord
  enum kind: { income_statement: 0 }

  has_many :line_items, class_name: "StatementLineItem", foreign_key: :statement_id
  belongs_to :accounting_period
end
