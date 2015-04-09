Rails.application.routes.draw do

  put "review/check"

  root "home#index"

  resources :cards
  resources :packs
  resources :users, except: [:new, :create]
  resources :registration, only: [:new, :create]
  resources :user_sessions
  resources :password, only: [:edit, :update]

  post "users", to: "registration#create"
  patch "set_current", to: "users#set_current_pack"
  patch "reset_current", to: "users#reset_current_pack"
  get "landing", to: "home#landing"

  get "login" => "user_sessions#new", as: :login
  get "logout" => "user_sessions#destroy", as: :logout

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider
end
