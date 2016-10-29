Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'welcome#index'

  get 'wall_art_services', to: 'project_requests#new'
  get 'wall_art_services/request_received', to: 'project_requests#request_received'

  get 'wallartservices', to: redirect('/wall_art_services')

  resources :project_requests, only: [:new, :create]
  resources :public_events, only: [:index, :new, :create, :show]
  resources :private_events, only: [:new, :create, :show]
  resources :experiences, only: [:index]
  resource :promos, only: [:show]
  resources :licensee_applications, only: [:new, :create]
  get 'thank_you', to: 'licensee_applications#thank_you', as: 'thank_you'
  resources :orders, only: [:new, :create, :show] do
    member do
      get 'cancel'
    end
  end
  get '/pages/:page' => 'pages#show', as: 'pages'
  resources :contacts, only: [:create]
  post '/contacts/partner' => 'contacts#partner'
end
