Rails.application.routes.draw do
  root "dashboard#index"

  get "up" => "rails/health#show", as: :rails_health_check

  get "registro", to: "registrations#new", as: :register
  post "registro", to: "registrations#create"

  get "login", to: "sessions#new", as: :login
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout

  get "password/recuperar", to: "passwords#new", as: :new_password
  post "password/recuperar", to: "passwords#create", as: :passwords

  resource :account_settings, only: %i[show edit update], path: "configuracion-cuenta"
  resources :collaborators, path: "colaboradores"
  resources :managed_users, path: "usuarios"
  get "algoritmos", to: "algorithms#index", as: :algorithms

  resources :services, only: %i[index create update destroy], path: "servicios"
end
