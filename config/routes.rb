Rails.application.routes.draw do
  get 'sessions/new'

  root 'main#index'

  get '/', to: 'main#index', as: :index

  get 'main/index'

  namespace :api do
    post 'articles/create'
  end

  get '/register', to: 'users#new', as: :new_user
  post '/users/create', to: 'users#create', as: :create_user

  get '/login', to: 'sessions#new', as: :new_session
  post '/login', to: 'sessions#create', as: :create_session
  delete '/logout', to: 'sessions#destroy', as: :destroy_session
end
