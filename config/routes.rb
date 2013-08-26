Fabfoundation::Application.routes.draw do

  get "password_resets/new"
  get "lab_applications/thank_you"
  get "static/home"
  get "static/secret"

  get "developers" => "static#developers", as: 'developers'
  get "privacy" => "static#privacy", as: 'privacy'

  get "signout" => "sessions#destroy", :as => "logout"
  get "signin" => "sessions#new", :as => "signin"
  get "signup" => "users#new", :as => "signup"

  resources :applications
  resources :password_resets
  resources :lab_applications

  get "labs" => 'labs#index'


  resources :events do
    collection do
      get 'calendar'
    end
  end

  resources :users do
    member do
      patch 'register'
      get 'change_password'
      patch 'update_password'
    end
  end

  resources :sessions

  get "complete_registration/:token" => 'users#complete_registration', :as => 'complete_registration'

  namespace "backstage" do
    resources :lab_applications
    resources :labs
    resources :users
    resources :events
    root "lab_applications#index"
  end

  resources :labs, path: '/' do
    collection do
      get 'map'
    end
  end

  root "labs#index"

end
