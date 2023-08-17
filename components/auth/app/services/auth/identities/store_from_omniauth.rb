module Auth
  module Identities
    class StoreFromOmniauth
      def initialize(on_new_identity: Auth.config.on_new_identity)
        @on_new_identity = on_new_identity
      end

      # @param auth [OmniAuth::AuthHash]
      #
      # @return [Auth::Identity]
      #
      def call(auth:)
        identity = find_or_initialize(auth)
        sync(identity, auth)

        on_new_identity.call(identity:, info: build_info(auth.info))

        identity
      end

      private

      attr_reader :on_new_identity

      def find_or_initialize(auth)
        Identity.find_or_initialize_by(provider: auth.provider, uid: auth.uid)
      end

      def sync(identity, auth)
        identity.update!(username: auth.info.email,
          doorkeeper_access_token: auth.credentials.token,
          doorkeeper_refresh_token: auth.credentials.refresh_token,
          doorkeeper_expires_at: Time.at(auth.credentials.expires_at)
        )
      end

      def build_info(raw_info)
        Auth::Info.new(raw_info.to_h.symbolize_keys)
      end
    end
  end
end
