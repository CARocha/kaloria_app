Rails.application.routes.draw do
  resources :calories
  devise_for :users
  root to: 'home#index'
end
