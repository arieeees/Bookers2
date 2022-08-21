Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get 'home/hello' => 'homes#hello'
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :books, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
