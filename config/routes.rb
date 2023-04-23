Rails.application.routes.draw do
  get '/me', to: "users#show"
  post '/login', to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/users", to: "users#index"
  post "/register", to: "users#create"
  resources :users, only: [:index, :show, :create, :destroy]

end
