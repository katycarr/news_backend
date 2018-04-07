Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :articles, only: [:index]

  resources :users, only: [:create]

  resources :topics, only: [:create, :destroy, :index]


  post '/login', to: 'auth#create'

  get '/get_user', to: 'auth#show'
end
