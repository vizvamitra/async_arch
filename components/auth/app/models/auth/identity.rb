module Auth
  class Identity < ApplicationRecord
    devise :rememberable, :omniauthable, omniauth_providers: %i[doorkeeper]
  end
end
