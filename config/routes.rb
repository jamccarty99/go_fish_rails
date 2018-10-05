Rails.application.routes.draw do
  get 'static_pages/login'
  get 'static_pages/main'
  get 'static_pages/settings'
  get 'static_pages/size'
  get 'static_pages/rule'
  get 'static_pages/game'
  get 'users/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root'application#hello'
end
