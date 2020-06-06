Rails.application.routes.draw do
  root 'static_pages#home'
  get '/static_pages/home', to: 'static_pages#home'
  get  '/signup',    to: 'static_pages#signup'
  resources :users
end