Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get '/chatrooms', to: 'chatrooms#index'

  resources :chatrooms, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end
end
