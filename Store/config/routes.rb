Rails.application.routes.draw do
  get 'comments/index'
  get 'comments/show'
  get 'comments/create'
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
  resources :users
end
