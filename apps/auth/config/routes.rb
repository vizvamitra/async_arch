Rails.application.routes.draw do
  devise_for :employees
  ActiveAdmin.routes(self)
  use_doorkeeper
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resource :employee, only: %i[show]
end
