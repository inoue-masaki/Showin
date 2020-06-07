Rails.application.routes.draw do
  get '/login' ,              to: 'sessions#new'
  root 'static_pages#home'
  get '/static_pages/home', to: 'static_pages#home'
  get  '/signup',    to: 'users#new'
  resources :users
end