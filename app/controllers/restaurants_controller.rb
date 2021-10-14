class RestaurantsController < ApplicationController

    def index 
        @restaurants = Restaurant.alpha
    end 

end
