Rails.application.routes.draw do
  root 'users#index', as: 'home'
  namespace :api do
  resources :users
  resources :carts do
  member do
    put :refresh
  end
  end
  resources :items do
  member do
    put :add_item_to_cart
    put :remove_item_from_cart
  end
  end
  resources :positions
  resources :comments
  resources :likes
  end
  end