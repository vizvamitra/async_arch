class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :lockable, :timeoutable, :trackable
  # and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable,
         :validatable

  enum role: { developer: 0, manager: 1, accountant: 2, admin: 3 }
end
