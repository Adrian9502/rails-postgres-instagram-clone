Rails.application.routes.draw do
  resources :follows, only: [ :create, :destroy ]
  resources :likes, only: [ :create, :destroy ]
  resources :comments
  devise_for :users
  get "home/about"
  get "posts/myposts"
  resources :posts

  resources :users, only: [ :show ]

  get "up" => "rails/health#show", as: :rails_health_check

  # Authenticated users see posts
  authenticated :user do
    root to: "posts#index", as: :authenticated_root
  end

  # Unauthenticated users see login - use standard Devise route
  root to: redirect("/users/sign_in")
end
