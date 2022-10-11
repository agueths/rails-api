Rails.application.routes.draw do
  devise_for :users
  resources :comments
  resources :articles, only: %i[index show create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
