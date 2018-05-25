Rails.application.routes.draw do
  root to: 'home#top'
  
  # Home
  get 'home/top'
  get 'home/tfdiary'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
  }
  
  # Users
  resources :users, :only => [:show] do
    collection do
      patch :change_image
      get :follow_menu
      get :unfollow_menu
      get :follow_user
      get :unfollow_user
      get :follow_diary
      get :unfollow_diary
    end
    
    member do
      get :follow_index
      get :follower_index
      get :menu_index
      get :group_index
      get :regist_menu
    end
    
    resources :diaries, shallow: true do
      # Comments
      resources :comments, :only => [:create, :destroy]
    end
  end

  # Menus
  resources :menus do
    collection do
      get :search
    end
  end

  # Groups
  resources :groups do
    collection do
      get :member_top
      get :member_index
      get :menu_confirm
      get :setting
    end
  end

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
