class Employee < ApplicationRecord
  enum role: { developer: 0, manager: 1, accountant: 2, admin: 3 }

  belongs_to :identity, class_name: "Auth::Identity", required: false
  has_many :tasks, inverse_of: :assignee

  validates :public_id, :email, :role, :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
