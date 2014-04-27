Noted::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount Peek::Railtie => '/peek'

  root 'noted#index'

  get '/application.manifest' => Rails::Offline

  get '/ui' => 'noted#ui'

  get '/new' => 'projects#new'

  devise_for :users

  devise_scope :user do
    get '/login'   => 'devise/sessions#new'
    get '/logout'  => 'devise/sessions#destroy'

    get '/join'    => 'devise/registrations#new'
    get '/account' => 'devise/registrations#edit'
  end

  get '/:user' => 'users#show'#, as: 'projects'

  get '/:user/:project' => 'projects#show'#, as: 'projects'
  get '/:user/:project/settings' => 'projects#edit'

  get '/:user/:project/notes' => 'notes#index'
  get '/:user/:project/notes/new' => 'notes#new'
  get '/:user/:project/notes/search' => 'notes#search'
  get '/:user/:project/notes/:note' => 'notes#show'

  get '/:user/:project/sources' => 'sources#index'
  get '/:user/:project/sources/new' => 'sources#new'
  get '/:user/:project/sources/:source' => 'sources#show'

  resources :projects, only: [:create, :update, :destroy]
  resources :notes, only: [:create, :update, :destroy]
  resources :sources, only: [:create, :update, :destroy]
end
