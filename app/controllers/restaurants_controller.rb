class RestaurantsController < ApplicationController

    def index 
        @restaurants = Restaurant.all
       # @restaurant = Restaurant.find_by_id(params[:id])
    end 

    def show 
        @restaurant.find_by_id[:id]
    end 

    def destroy 
        @restaurant.find_by_id[:id]
        @restaurant.delete
        redirect_to '/'
    end 




end
