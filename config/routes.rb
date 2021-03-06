Rails.application.routes.draw do
  root to: 'home#top'
  
  # Home
  get 'home/top'
  get 'home/tfdiary'
  get 'home/terms'
  get 'home/questions'

  devise_for :users, :skip => [:registration], controllers: {
    confirmations: 'users/confirmations',
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
  }
  
  devise_scope :user do
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: 'users',
      path_names: { new: 'sign_up' },
      controller: 'users/registrations',
      as: :user_registration do
        get :cancel
      end
  end

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
      get :unregist_confirm
      post :unregist
    end
    
    member do
      get :follow_index
      get :follower_index
      get :menu_index
      get :group_index
      get :regist_menu
      get :set_main_group
    end
    
    resources :diaries, shallow: true do
      collection do
        post :save_diary_all
        get :add_all_menu
        post :regist_menus
        post :save_diary_group
        get :select_group_menu
        get :read_group_menu
      end
      
      member do
        get :favoriter_index
      end
      
      # Comments
      resources :comments, :only => [:create, :destroy]
    end
  end

  # Menus
  resources :menus do
    collection do
      get :search
    end
    
    member do
      get :register_index
    end
  end

  # Groups
  resources :groups do
    collection do
      get :search
    end
    
    member do
      post :follow
      patch :follow_cancel
      patch :change_image
    end
    
    resources :group_member, :only => [:index], shallow: true do
      member do
        get :top
        get :setting
        get :menu_status
        get :request_index
        post :post_chat
        get :delete_chat
        get :assign_job
        patch :change_job
        post :follow_approve
        post :follow_reject
        get :unfollow_confirm
        get :unfollow
      end
    end
    
    resources :group_diaries do
      collection do
        post :add_all_menu
        post :regist_menus
      end
    end
  end

  # Contact
  get 'contacts/input'
  post 'contacts/confirm'
  post 'contacts/send_msg'

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
