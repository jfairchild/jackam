Rails.application.routes.draw do
  get 'welcome/index'
  get 'sessions/new'
  devise_for :users
  root 'welcome#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

end
