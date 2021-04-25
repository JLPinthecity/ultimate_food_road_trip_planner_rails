Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'welcome#home'
  get '/about', to: 'welcome#about'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
 
  get '/auth/facebook/callback' => 'sessions#create'
  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :trips 
end
