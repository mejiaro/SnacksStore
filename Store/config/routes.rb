Rails.application.routes.draw do
  devise_for :users
  root 'dashboard#index'
  namespace :product do
    get 'category'
  end
  resources :product
end
