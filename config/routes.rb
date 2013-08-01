Fabfoundation::Application.routes.draw do
  get "static/home"
  get "static/secret"

get "logout" => "sessions#destroy", :as => "logout"
get "login" => "sessions#new", :as => "login"
get "signup" => "users#new", :as => "signup"
resources :users
resources :sessions

  root 'static#home'
end
