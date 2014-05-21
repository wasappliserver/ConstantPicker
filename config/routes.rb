Rails.application.routes.draw do

  resources :at_strings

  resources :numbers

  get 'admin' => 'menu#home'
  get 'start_jenkins' => 'apps#start_jenkins'
  get 'start_jenkins_text' => 'apps#start_jenkins_text'

  controller :sessions do
    post 'login' => :create
    delete 'logout' => :destroy
    get 'logout' => 'menu#home'
    get 'login' => 'menu#home'
  end

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  resources :users do
    member do
      get 'edit2' => :edit2
    end
  end

  resources :couleurs

  resources :apps

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'menu#home'

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
