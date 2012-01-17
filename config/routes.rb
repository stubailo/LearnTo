Classroom::Application.routes.draw do

  resources :resources

  match 'activate(/:activation_code)' => "activations#create", :as => :activate_account

  get "forum/show"
 
  get "users/edit_password"
  
  get "users/edit_email"
  
  get "users/resend_activation"

  post "class_rooms/add_user"

  resources :class_rooms
  
  resources :forums
  
  resources :posts
  
  resources :comments
  
  resources :subcomments
  
  post "comments/plus1"
  
  post "comments/minus1"
  
  resources :users

  get "user_sessions/new"
  
  get "user_sessions/new_ajax"

  resources :user_sessions

  match 'login' => "user_sessions#new",      :as => :login
  match 'login_ajax' => "user_sessions#new_ajax",      :as => :login_ajax
  match 'logout' => "user_sessions#destroy", :as => :logout
 
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
