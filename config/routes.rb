Rails.application.routes.draw do
  # get 'users/index'
  # get 'users/show'
  # get 'users/edit'
  # get 'books/index'
  # get 'books/show'
  devise_for :users
  # get 'books',to: 'books#index'
  # get 'books',to: 'books#show'
  # post 'books' => 'books#create'
  # get 'books',to: 'books#edit'
  # get 'lists/show'
  # get 'lists/edit'
  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
end
  resources :books
  resources :users
  get '/home/about', to: 'homes#about', as: 'about'
  get 'users/homes/about', to: 'homes#about'
  get '/bookers', to: 'homes#top'
  root to: "homes#top"
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
