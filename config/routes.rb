Rails.application.routes.draw do
  devise_for :users
  resources :items
  root "items#index"
  resources :items do
    resources :orders, only: [:index, :create]
  end
end
