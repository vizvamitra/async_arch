# frozen_string_literal: true

class Auth::Identities::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def doorkeeper
    identity = Auth::Identities::StoreFromOmniauth.new.call(
      auth: request.env["omniauth.auth"]
    )

    if identity.persisted?
      sign_in_and_redirect identity, event: :authentication
      set_flash_message(:notice, :success, kind: "OAuth2") if is_navigational_format?
    else
      session["devise.oauth2_data"] = request.env["omniauth.auth"]
      redirect_to new_identity_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
