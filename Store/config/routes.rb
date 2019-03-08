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
  match '/car_shops', to: 'car_shops#create', via: 'post', as: :create_car
  match '/car_shops/destroy', to: 'car_shops#destroy', via: 'post', as: :destroy_car
  match '/orders/create', to: 'orders#create', via: 'post', as: :create_order
end
