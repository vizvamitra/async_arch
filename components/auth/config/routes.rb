Auth::Engine.routes.draw do
  devise_for :users, class_name: 'Auth::User', module: :devise, controllers: {
    omniauth_callbacks: 'auth/users/omniauth_callbacks',
    skip: [:sessions, :registrations]
  }

  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
    delete 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end
end
