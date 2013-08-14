Fabfoundation::Application.routes.draw do

  get "lab_applications/thank_you"
  get "static/home"
  get "static/secret"
  get "signout" => "sessions#destroy", :as => "logout"
  get "signin" => "sessions#new", :as => "signin"
  get "signup" => "users#new", :as => "signup"

  resources :applications

  resources :lab_applications do
  end

  resources :labs do
    collection do
      get 'map'
    end
  end

  resources :events do
    collection do
      get 'calendar'
    end
  end

  resources :users do
    member do
      patch 'register'
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
  root "labs#index"

end
