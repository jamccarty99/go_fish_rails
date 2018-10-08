Rails.application.routes.draw do
  # get '/login', to: 'static_pages#login'
  get '/main', to: 'static_pages#main'
  get '/settings', to: 'static_pages#settings'
  get '/size', to: 'static_pages#size'
  get '/rule', to: 'static_pages#rule'
  get '/game', to: 'static_pages#game'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
  root'static_pages#login'
end
