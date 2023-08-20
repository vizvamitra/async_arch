Rails.application.config.after_initialize do
  Auth.configure do |config|
    config.after_sign_in_path = "/dashboard"
    config.after_sign_out_path = "/"
    config.on_new_identity = proc do |identity:, info:|
      Employees::StoreFromAuth.new.call(identity:, info:)
    end
  end
end
