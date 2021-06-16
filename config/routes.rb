Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'relationships/create'
  get 'relationships/destroy'  
  
  root to:  'toppages#index'


  devise_for :users, controllers: {
     omniauth_callbacks: 'users/omniauth_callbacks',
   }
   
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

  resource :passwords, only: [:create, :update]



end     
