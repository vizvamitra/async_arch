Rails.application.routes.draw do
  mount Auth::Engine, at: "/"

  root "home#index"
  resource :dashboard, only: :show, controller: :dashboard
end
