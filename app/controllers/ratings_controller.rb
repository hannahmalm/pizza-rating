class RatingsController < ApplicationController

    def new 
        #route will look like /pizzas/1/ratings/new
        if @pizza = Pizza.find_by_id(params[:pizza_id]) #if the pizza is created
            @rating = @pizza.ratings.build  #rating belongs to a pizza
        else 
            @rating = Rating.new #create a new rating
        end 
    end 


    def index 

    end 


end
