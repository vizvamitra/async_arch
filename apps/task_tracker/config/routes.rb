Rails.application.routes.draw do
  mount Auth::Engine, at: "/"
  root "home#index"

  resources :tasks, only: %i[index new create] do
    scope module: :tasks do
      collection do
        resource :reassignment, only: %i[create], as: :task_reassignment
      end
      resources :completions, only: %i[create]
    end
  end
end
