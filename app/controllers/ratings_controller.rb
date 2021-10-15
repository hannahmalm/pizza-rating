class RatingsController < ApplicationController

    def new 
        #route will look like /pizzas/1/ratings/new
        if @pizza = Pizza.find_by_id(params[:pizza_id]) #if the pizza is created
            @rating = @pizza.ratings.build  #rating belongs to a pizza
        else 
            @rating = Rating.new #create a new rating
        end 
    end 

    def create 
        #you need to add in the user and pizza - a rating belongs to a User and Pizza
        @rating = Rating.create(rating_params)
        @rating 
        if @rating.save #checks to see if there is a pizza id
            redirect_to rate_path(@rate) #this is the same as saying /rating/:id
        else 
            render :new 
        end 
    end 

    def show 
        @rating = Rating.find_by_id(params[:id])
    end 

    def index 

    end 

    private 

    #because we are doing a hidden field, you need to specify this 
        def rating_params 
            params.require(:rating).permit(:pizza_id, :title, :rate, :comment, :url)
        end 


end
