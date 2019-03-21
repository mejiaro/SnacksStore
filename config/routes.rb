Rails.application.routes.draw do
  resources :comments
  devise_for :users
  root 'products#index'
  resources :products do
    resources :comments
  end
  resources :shopping_carts
  resources :orders
  resources :logs
  resources :order_details
  resources :like_products
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :products
      resources :sessions
      resources :users
    end
  end
  resources :users do
    resources :comments
  end
end
