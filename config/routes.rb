Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'welcome#home'
  get '/about', to: 'welcome#about'
  get '/auth/facebook/callback' => 'sessions#create'
  get '/signup' => 'users#new'

  resources :users, only: [:new, :create]

  resources :trips 
end
