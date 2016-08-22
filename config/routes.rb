Rails.application.routes.draw do
  root 'main#index'

  get 'main/index'

  namespace :api do
    post 'articles/create'
  end
end
