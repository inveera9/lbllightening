Rails.application.routes.draw do

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  mount Spree::Core::Engine, :at => '/'
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
  Spree::Core::Engine.routes.append do
     get '/about_us' => 'home#about_us', :as => :about_us
     get '/careers' => 'home#careers', :as => :careers
     get '/customer_service' => 'home#customer_service', :as => :customer_service
     get '/faqs' => 'home#faqs', :as => :faqs
     get '/shipping_delivery' => 'home#shipping_delivery', :as => :shipping_delivery
     get '/price_guarantee' => 'home#price_guarantee', :as => :price_guarantee
     get '/return_cancellation' => 'home#return_cancellation', :as => :return_cancellation
     get '/privacy_policy' => 'home#privacy_policy', :as => :privacy_policy
     get '/temrs_conditions' => 'home#temrs_conditions', :as => :temrs_conditions
     get '/contact_us' => 'home#contact_us', :as => :contact_us

  end
end