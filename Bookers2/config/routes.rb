Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  get 'homes/about' => 'homes#about'
  get 'users/index' => 'users#index'
  get 'books/index' => 'books#index'
  
  resources :users
  
  resources :books
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
