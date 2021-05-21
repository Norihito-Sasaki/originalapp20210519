Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'articles#index'
  
  resources :articles
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  
  get "signup", to: 'users#new'
  
  resources :users, only: [:show, :create] do
    member do
      get :articles
      get :interpretations
    end 
  end 
end
