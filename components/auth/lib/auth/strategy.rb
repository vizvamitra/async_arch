module Auth
  class Strategy < OmniAuth::Strategies::OAuth2
    option :name, :doorkeeper

    option :client_options,
           site: ENV["DOORKEEPER_APP_URL"],
           authorize_path: "/oauth/authorize"

    uid { raw_info["public_id"] }

    info do
      {
        public_id: raw_info["public_id"],
        email: raw_info["email"],
        role: raw_info["role"],
        first_name: raw_info["first_name"],
        last_name: raw_info["last_name"]
      }
    end

    def raw_info
      @raw_info ||= access_token.get("/user").parsed
    end
  end
end
