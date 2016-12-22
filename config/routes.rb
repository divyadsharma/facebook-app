FacebookApp::Application.routes.draw do
  resources :users
  root to: 'home#index'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  resources :password_resets, only: [:new, :create, :edit, :update]
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'users/new'
  resources :posts do
    member do
      post 'vote'
    end
    resources :comments do
      member do
        post 'vote'
      end
    end
  end

  get 'friendships/create'
  get 'friendships/update'
  get 'friendships/destroy'
  resources :home
  resources :friendships, only: [:create, :update, :destroy]
end
