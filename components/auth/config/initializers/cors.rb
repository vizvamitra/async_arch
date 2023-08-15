Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV.fetch("DOORKEEPER_APP_URL")
    resource '*', headers: :any, methods: %i[get post put patch delete options head]
  end
end
Rails.application.config.action_dispatch.cookies_same_site_protection = nil
