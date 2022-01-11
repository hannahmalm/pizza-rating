class RestaurantsController < ApplicationController
    before_action :not_logged_in_helper, on: [:index]
    def index 
        @restaurants = Restaurant.state_order
    end 






end
