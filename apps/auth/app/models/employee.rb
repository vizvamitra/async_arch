class Employee < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable,
         :validatable

  enum role: { developer: 0, manager: 1, accountant: 2, admin: 3 }

  validates :first_name, :last_name, :role, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
