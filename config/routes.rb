Rails.application.routes.draw do

#add in session and index routes
  get '/' => 'sessions#index'
  get '/login' => 'sessions#new' #this starts a new session when a user logs in 
  post '/login' => 'sessions#create' #post the login information to create the session
  get '/signup' => 'users#new'
  #you do not need a post sign up here because the user will be created 
  delete '/logout' => 'sessions#destroy' #destroy the session when a user logs out

  #get '/auth/google_oauth2/callback' => 'sessions#omniauth'
  get '/auth/:provider/callback' => 'sessions#create'
 

  

  resources :ratings
  resources :pizzas do 
  resources :ratings, only: [:new, :index]#nested routes
  end 
  resources :restaurants
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
