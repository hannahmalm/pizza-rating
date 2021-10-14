class RatingsController < ApplicationController

    def new 
        #route will look like /pizzas/1/ratings/new
        if @pizza = Pizza.find_by_id(params[:id])
            @rating = @pizza.rate.build  #rating belongs to a pizza
        else 
            @rating = Rating.new
        end 
    end 


    def index 

    end 


end
