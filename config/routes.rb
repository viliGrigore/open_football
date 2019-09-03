# frozen_string_literal: true
require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :teams do
    get :download_logo, on: :member
    get :return_multiple_sizes_logo, on: :member
  end

  resources :fans, only: %i[index show create update]

  post 'bulk_upload', to: 'teams#bulk_upload'
  resources :managers, only: %i[index show create update]
end
