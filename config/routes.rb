Rails.application.routes.draw do

#add in session and index routes
  get '/' => 'sessions#index'
  get '/login' => 'sessions#new' #this starts a new session when a user logs in 
  post '/login' => 'sessions#create' #post the login information to create the session
  get '/signup' => 'users#new'
  #you do not need a post sign up here because the user will be created 

  deleted '/logout' => 'sessions#destroy' #destroy the session when a user logs out

  resources :ratings
  resources :pizzas
  resources :restaurants
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
