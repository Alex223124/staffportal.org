require 'resque/server'

Staff::Application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config

  authenticated :user do
    mount Resque::Server, at: 'resque'
    ActiveAdmin.routes(self)

    devise_scope :user do
      get "auth/logout" => "devise/sessions#destroy"
    end

    namespace :staff do
      root :to => 'index#index'

      namespace :dmpd do
        root :to => 'index#index'
        get 'contacts' => 'index#contacts'
        resources :contacts
        resources :week6
        resources :week5
        resources :week4
        resources :week3
        resources :week2
        resources :week1
      end
      resources :accounts do
        member do
          get 'transactions'
        end
        collection do
          get 'change_default_currency/:code' => 'accounts#change_default_currency'
        end
      end
    end
  end

  match 'auth/key' => 'auth#key'
  root :to => 'auth#home'
end
