Rails.application.routes.draw do

  # Home page route
  root 'pages#home'

  # Routes for guests confirmation
  # resources :guests, only: [:new, :create], path: "confirmation", as: :confirmations
  get "guests", to: "guests#index", as: :guests
  get "confirmation", to: "guests#new", as: :new_confirmation
  post "confirmation", to: "guests#create", as: :confirmations
  resources :guests do
    patch :assign_table, on: :member
  end

  # Routes for the photo gallery
  get "gallery", to: "albums#index", as: :gallery

  resources :albums do
    member do
      get :download
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
