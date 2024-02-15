require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  mount Sidekiq::Web => '/sidekiq'

  # Defines the root path route ("/")
  root "movie#index"

  # Defines the route for the index action of the MovieController
  resources :movie, only: [:index]
end
