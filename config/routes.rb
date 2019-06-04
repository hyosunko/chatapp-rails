Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get '/chatrooms', to: 'chatrooms#index'
end
