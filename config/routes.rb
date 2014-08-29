Reddit::Application.routes.draw do
  root to: "users#new"

  resources :users
  resource :session, only: [:new, :create, :destroy]
end
