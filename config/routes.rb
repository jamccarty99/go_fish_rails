Rails.application.routes.draw do
  get 'waiting', to: 'static_pages#waiting'
  get '/size', to: 'static_pages#size'
  get '/rule', to: 'static_pages#rule'
  get '/game', to: 'static_pages#game'
  resources :games, only: [:show, :index]
  resources :sessions, only: [:new, :create, :index]
  resource :session, only: [:destroy]
  resources :users
  root'sessions#new'
end
