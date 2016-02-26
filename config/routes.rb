Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'welcome#index'

  resources :public_events, :private_events, :experiences
  resource :promos, only: [:show]
  resources :licensee_applications, only: [:new, :create]
  resources :orders do
    member do
      get 'cancel'
    end
  end
  get "/pages/:page" => "pages#show", as: 'pages'
  resources :contacts, only: [:create]
  post "/contacts/partner" => "contacts#partner"
end
