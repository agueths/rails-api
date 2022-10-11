Rails.application.routes.draw do
  resources :comments
  resources :articles, only: %i[index show create]
  resources :users, only: [:create]
  post '/login', to: 'users#login'
end
