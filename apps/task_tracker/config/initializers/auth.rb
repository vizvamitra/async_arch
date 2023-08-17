Rails.application.config.after_initialize do
  Auth.configure do |config|
    config.after_sign_in_path = "/tasks"
    config.after_sign_out_path = "/"
    config.on_new_identity = Employees::StoreFromAuth.new
  end
end
