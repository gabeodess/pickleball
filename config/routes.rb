Rails.application.routes.draw do
  resources :pushers, only: [:create]
  resource :password, only: [:new, :create, :edit, :update] do
    get :reset
  end
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  namespace :api do
    resource :session, only: [:show]
    resource :user, only: [:update]
    resources :users, only: [:show]
    resources :groups, only: [:create, :index, :show] do
      resources :messages, only: [:create, :index]
      resources :members, only: [:create, :index]
    end

    namespace :dupr do
      resource :session, only: [:create]
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'sessions#show'

  match '/*path', to: 'sessions#show', via: :get
end
