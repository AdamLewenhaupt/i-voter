Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users

  get 'admin' => "admin#index"
  post 'admin/auth' => "admin#auth"
  post 'admin/start' => "admin#start"
  post 'admin/end' => "admin#stop"
  post 'update-location' => 'admin#update_location'

  get 'vote/start' => "vote#start"
  get 'vote/stop' => "vote#stop"

  get 'polls/latest' => "polls#latest"
  post 'polls/:id/open' => "polls#open"
  post 'polls/:id/close' => "polls#close"
  get 'polls/:poll_id/poll_options/:id/vote' => "poll_options#vote"

  resources :polls do
    resources :poll_options
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  post 'auth' => 'auth#verify'

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
