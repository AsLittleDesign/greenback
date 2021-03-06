Rails.application.routes.draw do
  get 'sessions/new'

  # Route to the site index
  root 'base#application'

  # Login and signup pages
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  # Dashboard
  get 'dashboard' => 'users#dashboard'

  # Budgets
  get 'budgets' => 'base#application'
  post 'budgets' => 'budgets#create'

  get 'budgets/:id' => 'base#application'

  scope "api" do
    resources :budgets, defaults: { format: "json" } do
      resources :history, defaults: { format: "json" }
    end

    resources :users, defaults: { format: "json" }

  end

  # Bills page
  get 'bills' => 'bills#index'
  post 'bills' => 'bills#create'
  resources :bills

  # Bills page
  get 'debts' => 'debts#index'
  post 'debts' => 'debts#create'
  resources :debts
end
