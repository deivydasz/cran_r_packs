require 'sidekiq/web'
require 'sidecloq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
  resources :authors
  resources :maintainers
  resources :packages

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
