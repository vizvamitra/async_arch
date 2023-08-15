Rails.application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)
  use_doorkeeper
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resource :user, only: %i[show]
end
