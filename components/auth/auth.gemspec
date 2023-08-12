require_relative "lib/auth/version"

Gem::Specification.new do |spec|
  spec.name        = "auth"
  spec.version     = Auth::VERSION
  spec.authors     = ["vizvamitra"]
  spec.email       = ["5035283+vizvamitra@users.noreply.github.com"]
  spec.homepage    = "https://github.com/vizvamitra/async_auth"
  spec.summary     = "Popug auth"
  spec.description = "Auth engine for Popug Inc. services"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://popug.inc"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/vizvamitra/async_auth"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.6"
  spec.add_dependency "devise"
  spec.add_dependency "omniauth-oauth2"
  spec.add_dependency "omniauth-rails_csrf_protection"
  spec.add_dependency "rack-cors"
end
