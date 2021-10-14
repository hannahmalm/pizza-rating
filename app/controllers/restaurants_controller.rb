class RestaurantsController < ApplicationController

    def index 
        @restaurants = Restaurant.all
       # @restaurant = Restaurant.find_by_id(params[:id])
    end 

end
