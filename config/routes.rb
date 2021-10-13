Rails.application.routes.draw do

#add in session and index routes
get '/' => 'sessions#index'


  resources :ratings
  resources :pizzas
  resources :restaurants
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
