class PaymentCycle < ApplicationRecord
  belongs_to :employee, inverse_of: :payment_cycles

  def self.current
    find_by(closed: false)
  end
end
