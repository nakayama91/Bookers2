Rails.application.routes.draw do
  get 'users/show'
  devise_for :users

  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get 'users/index' => 'users#index'
  resources :books, only: [:create, :index, :show, :edit, :destroy]
end
