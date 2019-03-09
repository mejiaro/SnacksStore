Rails.application.routes.draw do
  devise_for :users
  root 'product#index'
  namespace :product do
    get 'category'
  end
  resources :product
  resources :car_shops
  resources :orders
  resources :order_details
  resources :like_products
end
