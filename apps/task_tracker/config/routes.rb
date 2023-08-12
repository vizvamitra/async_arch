Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  mount Auth::Engine, at: "/"
  root "home#index"

  # Defines the root path route ("/")
end
