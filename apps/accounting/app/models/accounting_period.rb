class AccountingPeriod < ApplicationRecord
  validates :start, :end, :description, presence: true

  def self.current
    find_by(closed: false)
  end
end
