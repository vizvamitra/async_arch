Rails.application.routes.draw do
  mount Auth::Engine, at: "/"
  root "home#index"

  resources :tasks, only: %i[index new create] do
    collection { post "reassign", to: "tasks#reassign" }
  end
end
