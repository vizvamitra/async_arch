class Account < ApplicationRecord
  enum category: {
    asset: 1,
    liability: 2,
    equity: 3,
    revenue: 4,
    expense: 5,
    temporary: 6
  }
  enum contra: { non_contra: 1, contra: -1 }
  enum natural_balance: { debit_balance: 1, credit_balance: -1 }

  has_one :employee, required: false, inverse_of: :account
  has_many :entries, inverse_of: :account
  has_many :transfers, through: :entries
  belongs_to :owner, class_name: 'Employee', required: false, inverse_of: :account

  validates :number, :category, :name, presence: true

  scope :employees, -> { where(number: Accounts::Numbers::EMPLOYEE) }

  def balance
    entries.sum(<<~SQL.squish)
      CASE WHEN side = #{ '-' if credit_balance? }1 THEN amount ELSE -amount END
    SQL
  end

  def self.cash_asset
    find_by!(number: Accounts::Numbers::CASH)
  end

  def self.capital_equity
    find_by!(number: Accounts::Numbers::CAPITAL)
  end

  def self.task_assignment_revenue
    find_by!(number: Accounts::Numbers::TASK_ASSIGNMENT_FEES)
  end

  def self.task_completion_expense
    find_by!(number: Accounts::Numbers::TASK_COMPLETION_REWARDS)
  end

  def self.income_summary_temporary
    find_by!(number: Accounts::Numbers::INCOME_SUMMARY)
  end
end
