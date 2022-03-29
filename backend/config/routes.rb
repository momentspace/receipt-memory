# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :images
      resources :receipts
      match 'categories', controller: :receipts, action: :category, via: :get
      resources :users
      resources :shops
    end
  end
end
