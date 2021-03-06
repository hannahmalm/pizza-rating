class PizzasController < ApplicationController
    before_action :not_logged_in_helper, on: [:create, :show, :index] #before each method, verify that a user is logged in
    def new 
        @pizza = Pizza.new 
        @pizza.build_restaurant #tell pizza to build the restaurant because its within a nested form
    end 

    def create 
        @pizza = Pizza.new(pizza_params)
        @pizza.user_id = session[:user_id]
            if @pizza.save #validations occur on the save
                redirect_to pizza_path(@pizza), :notice => "Your Pizza Was Saved"
            else 
                @pizza.build_restaurant
                render :new
            end 
    end 

    def index #this is an index action
        #@pizzas = Pizza.all.order_by_rating
        @pizzas = Pizza.all
        @pizza = Pizza.find_by_id(params[:id])
        @most_popular_pizza = Pizza.highest_avg_rating_order.first    #show most popular pizza here
    end 

    def show 
        @pizza = Pizza.find_by_id(params[:id])
    end 

    def most_popular_pizza
        @most_popular_pizza =  Pizza.highest_avg_rating_order.first
        @second_popular_pizza = Pizza.highest_avg_rating_order.second
        @third_popular_pizza = Pizza.highest_avg_rating_order.third
    end 


    private 

        def pizza_params #strong params - provides an interface for protecting attributes from end-user assignment
            #parameters can be marked as required and flow through a predefined raise/rescue flow to end up as a 400 Bad Request with no effort
            #In order to use accepts_nested_attributes_for with Strong Parameters, you will need to specify which nested attributes should be permitted
            params.require(:pizza).permit(:specialtyname, :toppings, :restaurant_id, restaurant_attributes: [:name,:city,:state,:website])
        end 

        def pizza_find_by
            @pizza = Pizza.find_by_id(params[:id])
        end 

       
end
