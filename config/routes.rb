Rails.application.routes.draw do
  get '/main', to: 'static_pages#main'
  get '/settings', to: 'static_pages#settings'
  get '/size', to: 'static_pages#size'
  get '/rule', to: 'static_pages#rule'
  get '/game', to: 'static_pages#game'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  root'sessions#new'
end
