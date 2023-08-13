module Auth
  class User < ApplicationRecord
    devise :rememberable, :omniauthable, omniauth_providers: %i[doorkeeper]

    enum role: { developer: 0, manager: 1, accountant: 2, admin: 3 }
  end
end
