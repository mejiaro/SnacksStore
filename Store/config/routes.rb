Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
  resources :products
  resources :car_shops
  resources :orders
  resources :logs
  resources :order_details
  resources :like_products
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :products
    end
  end
end
