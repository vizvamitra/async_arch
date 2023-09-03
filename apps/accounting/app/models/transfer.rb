class Transfer < ApplicationRecord
  enum kind: {
    task_assignment_fee: 0,
    task_completion_reward: 1,
    contribution: 2, # When owners contribute to the company's capital
    revenue_closing: 3,
    expense_closing: 4,
    income_summary_closing: 5,
    payout_to_employee: 6
  }

  has_many :entries, inverse_of: :transfer
  belongs_to :reference, polymorphic: true, required: false
  belongs_to :accounting_period

  validates :description, presence: true

  scope :for, ->(period) { where(accounting_period: period) }
end
