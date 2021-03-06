Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/session#guest_sign_in'
  end

  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings', on: :member #=> 'relationships#followings', as: 'followings'
    get 'followers', on: :member #=> 'relationships#followers', as: 'followers'
    get "search", to: "users#search"
  end

  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  get '/search' => 'searchs#search'

  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]

  resources :groups do
    get 'join' => 'groups#join'
    get 'new/mail' => 'groups#new_mail'
    get 'send/mail' => 'groups#send_mail'
  end

end
