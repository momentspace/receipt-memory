Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :images
      resources :receipts
      resources :users
      resources :shops
    end
  end
end
