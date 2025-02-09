Rails.application.routes.draw do
  get 'dashboard/index'
  get 'dashboard/csv'
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
  get "home", to: "home#index"
  get "users/register", to: "users#new"  # Link for the registration form

  resources :users, only: [:new, :create, :index]

  # Dashboard routes for consulting data and CSV export
  get "dashboard", to: "dashboard#index"
  get "dashboard/csv", to: "dashboard#csv", as: "export_csv"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
