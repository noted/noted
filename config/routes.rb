Noted::Application.routes.draw do
  root 'noted#index'

  get '/ui' => 'noted#ui'

  get '/new' => 'projects#new'

  devise_for :users

  devise_scope :user do
    get '/login'  => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'

    get '/join'   => 'devise/registrations#new'
  end

  get '/:user' => 'users#show'#, as: 'projects'

  get '/:user/:project' => 'projects#show'#, as: 'projects'
  get '/:user/:project/settings' => 'projects#edit'

  get '/:user/:project/notes' => 'notes#index'
  get '/:user/:project/notes/new' => 'notes#new'
  get '/:user/:project/notes/:note' => 'notes#show'

  get '/:user/:project/sources' => 'sources#index'
  get '/:user/:project/sources/new' => 'sources#new'
  get '/:user/:project/sources/:source' => 'sources#show'

  resources :projects, only: [:create, :update, :destroy]
  resources :notes, only: [:create, :update, :destroy]
  resources :sources, only: [:create, :update, :destroy]

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
