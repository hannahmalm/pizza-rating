class PizzasController < ApplicationController

    def index 
        @pizzas = Pizza.all.order_by_rating
    end 

    def new 
        @pizza = Pizza.new 
        #tell pizza to build the restaurant because its within a nested form
        @pizza.build_restaurant
    end 

    def create 
        @pizza = Pizza.new(pizza_params)
        @pizza.user_id = session[:user_id]
            if @pizza.save 
                @pizza.image.purge 
                @pizza.image.attatch(params[:pizza][:image])
                redirect_to pizza_path(@pizza), :notice => "Your Pizza Was Saved"
            else 
                @pizza.build_restaurant
                render :new
            end 
    end 

   

    def show 
        @pizza = Pizza.find_by_id(params[:id])
    end 


    private 

        def pizza_params
            params.require(:pizza).permit(:specialtyname, :toppings, :restaurant_id, restaurant_attributes: [:name,:city,:state,:website])
        end 
end
