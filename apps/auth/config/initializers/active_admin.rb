# frozen_string_literal: true

ActiveAdmin.setup do |config|
  config.site_title = "Auth"
  config.authentication_method = :authenticate_user!
  config.current_user_method = :current_user
  config.logout_link_path = :destroy_user_session_path
  config.comments = false
  config.batch_actions = true
  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]
  config.localize_format = :long

  config.namespace :admin do |admin|
    admin.build_menu do |menu|
      menu.add label: "OAuth Applications", url: "http://localhost:3000/oauth/applications"
    end
  end
end
