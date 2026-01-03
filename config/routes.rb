Rails.application.routes.draw do
  devise_for :users
  get "home/about"
  resources :posts
  devise_scope :user do
    get "/users", to: "devise/registrations#new"
    get "/users/password", to: "devise/passwords#new"
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "posts#index"
end
