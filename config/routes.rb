# frozen_string_literal: true

Rails.application.routes.draw do
  resources :movements
  resources :trainings
  resources :training_items, path: 'training-items'

  post '/webhooks/email', to: 'email_webhook#handle'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
