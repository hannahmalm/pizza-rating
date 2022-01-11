class UsersController < ApplicationController
    before_action :not_logged_in_helper, on: [:create, :show, :index] #before each method, verify that a user is logged in

    def new 
        @user = User.new
    end 

    def create 
        @user = User.new(user_params)
        if @user.save 
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else 
            render :new 
        end
    end 

    def show
        @user = User.find_by_id(params[:id])
    end 

    def index
        
    end     

    # def current_user #this method needs to return user that is found by session user id
    #     #||= will only call db once if you are using current user more than once in a method 
    #     #find by id so that if the id is null it wont error out
    #     @current_user ||= User.find_by_id(session[:user_id])
    # end 

    private 

    #this is where you define user_params - user_params is not an action
    def user_params 
        params.require(:user).permit(:username, :password)
    end 

end
