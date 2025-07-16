Rails.application.routes.draw do
  root 'home#index'

  # get "leave_requests/destroy"
  # get "home", to: "home#index"

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy", as: :logout

  resources :users, only: [:new, :create, :index, :show]

  resources :leave_requests do
    member do
      patch :approve
    end
  end
end
