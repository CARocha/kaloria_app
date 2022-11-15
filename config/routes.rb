Rails.application.routes.draw do
  resources :calories
  devise_for :users
  get '/documentation', to: 'home#documentation'
  get '/dashboard', to: 'home#dashboard'
  get '/sharedp', to: 'home#shared_progress'
  root to: 'home#index'
end
