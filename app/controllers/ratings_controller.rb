class RatingsController < ApplicationController

    def new 
        #route will look like /pizzas/1/ratings/new
        @pizza = Pizza.find_by_id(params[:id])
        @rating = @pizza.build_rating 
    end 


    def index 

    end 
end
