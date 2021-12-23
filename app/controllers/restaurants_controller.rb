class RestaurantsController < ApplicationController

    def index 
        @restaurants = Restaurant.state_order
    end 






end
