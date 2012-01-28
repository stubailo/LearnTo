Classroom::Application.routes.draw do
  
  match "class_rooms/:id/plus1" => "class_rooms#plus1", :as => :class_rooms_plus1, :via => :post
  
  match "class_rooms/:id/minus1" => "class_rooms#minus1", :as => :class_rooms_minus1, :via => :post
  
  match "comments/:id/edit" => "comments#edit", :via => :put
  
  match "posts/:id/edit" => "posts#edit", :via => :put
  
  match "comments/:id/plus1" => "comments#plus1", :as => :comments_plus1, :via => :post
  
  match "comments/:id/minus1" => "comments#minus1", :as => :comments_minus1, :via => :post
  
  get "class_rooms/class_names"
  
  get "students/show"
  
  get "forums/search_by_tag"
  
  get "forums/search" 
  
  get "class_rooms/search"

  match '/auth/:provider/callback' => 'authentications#create'

  get "authentications/index"

  get "authentications/create"

  get "authentications/destroy"

  get "document/show"

  get "document/edit"

  get "document/update"

  get "document/new"

  get "document/create"

  get "document/destroy"

  match 'activate(/:activation_code)' => "activations#create", :as => :activate_account
 
  get "users/edit_password"
  
  get "users/edit_email"
  
  get "users/resend_activation"

  post "class_rooms/add_user"
  
  get "class_rooms/del_user"
  
  resources :user_permissions

  resources :class_rooms do
    resources :announcements do
    end
    resources :resource_pages do
      resources :sections do
        resources :resources do
          resources :resource_comments
          match 'documents/:id/create_doc_rec' => "documents#create_doc_rec", :as => :doc_rec, :via => :post
        end
        match 'resources/:id/change_hidden' => "resources#change_hidden", :as => :publish
        match 'resources/:id/change_completed' => "resources#change_completed", :as => :completed
        match 'resources/:id/change_order' => "resources#change_order", :as => :rearrange
      end
      match 'sections/:id/change_order' => "sections#change_order", :as => :rearrange
      match 'sections/:id/update' => "sections#update", :as => :update, :via => :post
    end
  end
  
  match 'class_rooms/:id/change_active' => "class_rooms#change_active", :as => :activate
  match 'class_rooms/:id/begin_class' => "class_rooms#begin_class", :as => :begin
  
  resources :authentications
  
  resources :forums
  
  resources :posts  
  
  resources :comments
  
  resources :subcomments
  
  resources :users

  get "user_sessions/new"
  
  get "user_sessions/new_ajax"
  
  get "home/teacher_index"
  
  get "home/index"
  
  get "home/manage"

  get "home/please_register"
  
  

  resources :user_sessions

  match 'login' => "user_sessions#new",      :as => :login
  match 'login_ajax' => "user_sessions#new_ajax",      :as => :login_ajax
  match 'logout' => "user_sessions#destroy", :as => :logout
  
  get "auth/facebook"
 
  resources :pages, :only => :show

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
