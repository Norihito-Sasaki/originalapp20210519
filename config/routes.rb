Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'articles#index'
  
  resources :articles do
    resources :interpretations, only: [:new, :create, :edit, :update, :destroy]
  end
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  
  get "signup", to: 'users#new'
  
  resources :users, only: [:show, :create, :edit, :update, :destroy] do
    member do
      get :articles
      get :interpretations
    end 
  end 
end
