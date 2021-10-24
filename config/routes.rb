Rails.application.routes.draw do

  devise_for :users

  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as:'followings'
    get 'followers' => 'relationships#followers', as:'followers'
  end
    
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

end
