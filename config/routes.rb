Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'relationships/create'
  get 'relationships/destroy'  
  
  root to:  'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end

  resources :recipes, only: [:index, :new, :show, :create, :edit, :update, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only:[:create, :destroy]

end     
