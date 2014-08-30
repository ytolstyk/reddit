Reddit::Application.routes.draw do
  root to: "users#new"

  resources :users
  resource :session, only: [:new, :create, :destroy]
  
  resources :subs do
    resources :posts, only: [:new]
  end
  
  resources :posts, except: [:new]
  resources :comments, only: [:create, :show]
end
