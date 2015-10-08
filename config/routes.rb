Rails.application.routes.draw do
    devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

    get "/about" => "topics#about"
    get "/me" => "introductions#show"

    resources :friendships

    resources :introductions # better naming: profiles

    resources :topics do
      resources :comments, :controller => "topic_comments"
      resources :tags, :controller => "topic_tags"

      collection do
        post :bulk_delete
      end

      member do
        post :collect   # TODO: change to post OK
        post :like      # TODO: change to post OK
        post :subscribe # TODO: change to post OK
      end
  end

  namespace :admin do
    resources :topics
    resources :users
    resources :categories
    resources :tags
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'topics#index'
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
