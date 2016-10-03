Rails.application.routes.draw do
  root 'main#index'

  get '/', to: 'main#index', as: :index

  get 'main/index'

  namespace :api do
    post 'articles/create'
  end

  get '/register', to: 'users#new', as: :new_user
  post '/users/create', to: 'users#create', as: :create_user
end
