Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :hosts, only: :index
      resources :messages

      get 'clear' => 'debug#clear'
      get 'broadcast' => 'debug#broadcast'

      get 'hosts/local' => 'hosts#local'
      get 'messages/validate/:uuid' => 'messages#validate'


      post 'hosts/add' => 'hosts#add'

      post "messages/receive" => 'messages#receive'
      post "host_register" => 'hosts#register'
      post "discover" => 'hosts#discover'



      post 'request_email' => 'tip#request_email'
      post 'send_email' => 'tip#send_email'
      post 'inbound_email_request' => 'tip#inbound_email_request'
      post 'inbound_email_response' => 'tip#inbound_email_response'

    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'app#index'

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
