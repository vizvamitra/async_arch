module Auth
  module Users
    class StoreFromOmniauth
      # @param auth [OmniAuth::AuthHash]
      #
      # @return [Auth::User]
      #
      def call(auth:)
        user = find_or_initialize(auth)
        sync(user, auth)

        user
      end

      def find_or_initialize(auth)
        User.find_or_initialize_by(provider: auth.provider, uid: auth.uid)
      end

      def sync(user, auth)
        user.update!(
          email: auth.info.email,
          role: auth.info.role,
          first_name: auth.info.first_name,
          last_name: auth.info.last_name,
          doorkeeper_access_token: auth.credentials.token,
          doorkeeper_refresh_token: auth.credentials.refresh_token,
          doorkeeper_expires_at: Time.at(auth.credentials.expires_at)
        )
      end
    end
  end
end
