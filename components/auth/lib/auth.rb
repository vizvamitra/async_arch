require "auth/version"
require "auth/engine"

require "rack/cors"
require "devise"
require "omniauth/strategies/oauth2"
require "omniauth/rails_csrf_protection"
require "dry-struct"

module Auth
  Types = Dry.Types()

  class Configuration
    attr_accessor :after_sign_in_path, :after_sign_out_path, :on_new_identity
  end

  class << self
    attr_reader :config

    def configure
      @config = Configuration.new
      yield config
    end
  end
end
