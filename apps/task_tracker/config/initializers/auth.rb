Auth.configure do |config|
  config.after_sign_in_path = "/tasks"
  config.after_sign_out_path = "/"
end
