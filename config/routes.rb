Condomotion2::Application.routes.draw do

  resources :roles

  match '/:post_type/new', to: 'posts#new'
  %W[documents news photos].each do |type|
    match '/'+type+'/new', to: 'posts#new', as: 'new_'+type
  end 

  resources :posts

  resources :memberships do
    collection do
      post 'batch_create_managers'
      post 'batch_create_residents'
    end
  end

  resources :sites

  resources :companies

  get "company/edit"

  get "company/update"

  get "company/destroy"

  devise_for :users

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.


  %w[about contact pricing].each do |page|
    get page, controller: "home", action: page, :as => page
  end
  match '/', to: 'sites#show', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  match '/:post_type', to: 'sites#show'

  root :to => 'home#index'
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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
