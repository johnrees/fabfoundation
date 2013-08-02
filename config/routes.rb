Fabfoundation::Application.routes.draw do


  get "labs/thank_you"
  get "static/home"
  get "static/secret"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  resources :labs
  resources :events
  resources :users
  resources :sessions

  namespace "backstage" do
    resources :labs
    root "labs#index"
  end

  root 'static#home'

end
