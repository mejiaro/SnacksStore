Rails.application.routes.draw do
  get 'rol/rol_name:string'
  devise_for :users
  root 'product#index'
  resources :product
  resources :car_shops
  resources :orders
  resources :order_details
  resources :like_products
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :product
    end
  end
end
