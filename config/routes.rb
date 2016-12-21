FacebookApp::Application.routes.draw do
  resources :users
  root to: 'home#index'
  get "password_resets/new"
  get "password_resets/edit"
  get "sessions/new"
  resources :password_resets,     only: [:new, :create, :edit, :update]
  # get '/sign_up', to: 'users#new'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get "users/new"
  resources :posts do
    resources :comments do
      member do
        put 'like', to: 'comments#upvote'
        put 'dislike', to: 'comments#downvote'
      end
    end
    member do
      put 'like', to: 'posts#upvote'
      put 'dislike', to: 'posts#downvote'
    end
  end

  get 'friendships/create'
  get 'friendships/update'
  get 'friendships/destroy'
  # devise_for :users
  resources :home
  # devise_for :users, controllers: { registrations: 'registrations' } do
  #   post '/sign_up' => 'registrations#create'
  # end
  # root to: 'home#index'
  # authenticated :user do
  #   root to: 'home#index', as: :authenticated_root
  # end
  resources :friendships, only: [:create, :update, :destroy]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
