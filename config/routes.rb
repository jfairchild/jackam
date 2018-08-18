# frozen_string_literal: true

# routes
Rails.application.routes.draw do
  get 'welcome/index'
  get 'sessions/new'

  root 'welcome#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
