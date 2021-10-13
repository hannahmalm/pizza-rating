class PizzasController < ApplicationController

    def new 
        @pizza = Pizza.new 
        @pizza.build_restaurant
    end 

    def create 
        @pizza = Pizza.new(pizza_params)
        @pizza.user_id = session[:user_id]
        if @pizza.save 
            redirect_to pizza_path(@pizza)
        else 
            render :new 
        end 
    end 

    def pizza_params
        params.require(:pizza).permit(:specialtyname, :toppings, :restaurant_id, :restaurant_attributes [:name])
    end 
end
