Rails.application.routes.draw do
  get 'sessions/new'

  # Route to the site index
  root 'content#index'

  # Login and signup pages
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :users

  # Dashboard
  get 'dashboard' => 'users#dashboard'

  # Budgets page
  get 'budgets' => 'budgets#index'
  post 'budgets' => 'budgets#create'
  post 'budgets' => 'budgets#update'
  resources :budgets

  # Bills page
  get 'bills' => 'bills#index'
  post 'bills' => 'bills#create'
  resources :bills

  # Bills page
  get 'debts' => 'debts#index'
  post 'debts' => 'debts#create'
  resources :debts
end
