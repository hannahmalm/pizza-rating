Rails.application.routes.draw do

#add in session and index routes
#guides.rubyonrails.orb/routing.html
  get '/' => 'sessions#index'
  get '/login' => 'sessions#new' #this starts a new session when a user logs in 
  post '/login' => 'sessions#create' #post the login information to create the session
  delete '/logout' => 'sessions#destroy' #destroy the session when a user logs out

  get '/signup' => 'users#new'  #you do not need a post sign up here because the user will be created 

  get '/auth/google_oauth2/callback' => 'sessions#omniauth'
  #get '/auth/:provider/callback' => 'sessions#create' #only use this if there are multiple providers

  get '/pizzas/most_popular_pizzas' => 'pizzas#most_popular_pizza'
 
  #resources writes out the 7 restful routes, but only write the routes for methods you are using.
  resources :ratings
  resources :pizzas do 
  resources :ratings, only: [:new, :index, :show] #nested routes
  end 
  resources :restaurants
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
