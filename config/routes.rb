Rails.application.routes.draw do
  resources :comments
  devise_for :users
  get "home/about"
  get "posts/myposts"
  resources :posts

  # devise_scope :user do
  #   get "/users", to: "devise/registrations#new"
  #   get "/users/password", to: "devise/passwords#new"
  #   get "/users/sign_out", to: "devise/sessions#destroy"
  # end

  resources :users, only: [ :show ]

  get "up" => "rails/health#show", as: :rails_health_check

  # Authenticated users see posts
  authenticated :user do
    root to: "posts#index", as: :authenticated_root
  end

  # Unauthenticated users see login - use standard Devise route
  root to: redirect("/users/sign_in")
end
