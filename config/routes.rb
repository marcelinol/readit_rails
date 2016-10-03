Rails.application.routes.draw do
  root 'main#index'

  get '/', to: 'main#index', as: :index

  get 'main/index'

  namespace :api do
    post 'articles/create'
  end
end
