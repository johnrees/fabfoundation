Fabfoundation::Application.routes.draw do

  get "labs/thank_you"
  get "static/home"
  get "static/secret"
  get "signout" => "sessions#destroy", :as => "logout"
  get "signin" => "sessions#new", :as => "signin"
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
