Rails.application.routes.draw do
  mount Auth::Engine, at: "/"
  root "home#index"

  resource :dashboard, controller: :dashboard, only: :show
end
