class Employee < ApplicationRecord
  enum role: { developer: 0, manager: 1, accountant: 2, admin: 3 }

  belongs_to :identity, class_name: "Auth::Identity", required: false
  has_one :account, foreign_key: :owner_id, inverse_of: :owner

  validates :public_id, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
