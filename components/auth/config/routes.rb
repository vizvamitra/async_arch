Auth::Engine.routes.draw do
  devise_for :identities, class_name: 'Auth::Identity', module: :devise, controllers: {
    omniauth_callbacks: 'auth/identities/omniauth_callbacks',
    skip: [:sessions, :registrations]
  }

  devise_scope :identity do
    get 'identities/sign_in', to: 'identities/sessions#new', as: :new_identity_session
    delete 'identities/sign_out', to: 'identities/sessions#destroy', as: :destroy_identity_session
  end
end
