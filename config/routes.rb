Rails.application.routes.draw do

  root "home#index"

  scope "(:locale)" do
    resources :cards
    resources :packs
    resources :users, except: [:new, :create]
    resources :registration, only: [:new, :create]
    resources :user_sessions
    resources :password, only: [:edit, :update]

    post "users", to: "registration#create"
    patch "set_current_pack", to: "users#set_current_pack"
    patch "reset_current_pack", to: "users#reset_current_pack"
    get "landing", to: "home#landing"
    post "change_locale", to: "home#change_locale"
    put "review/check"

    get "login" => "user_sessions#new", as: :login
    get "logout" => "user_sessions#destroy", as: :logout

    post "oauth/callback" => "oauths#callback"
    get "oauth/callback" => "oauths#callback"
    get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider
  end
end
