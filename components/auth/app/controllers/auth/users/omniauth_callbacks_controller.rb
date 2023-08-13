# frozen_string_literal: true

class Auth::Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # skip scrf protection
  skip_before_action :verify_authenticity_token, only: :doorkeeper

  def doorkeeper
    user = Auth::Users::StoreFromOmniauth.new.call(auth: request.env["omniauth.auth"])

    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: "OAuth2") if is_navigational_format?
    else
      session["devise.oauth2_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
