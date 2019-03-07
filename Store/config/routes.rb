Rails.application.routes.draw do
  devise_for :users
  root 'dashboard#index'
  namespace :product do
    get 'category'
  end
  resources :product
  resources :car_shops
  match '/car_shops', to: 'car_shops#create', via: 'post', as: :create_car
end
