class SessionsController < ApplicationController
    def index 
        #allows the index page to load
    end 

    def destroy 
        #the logout link/button should be within the layouts page
        #in rails use delete instead of destroy - destroy is the preferred command when deleting objects, not sessions
        session.delete(:user_id)
        redirect_to '/'
    end 

    def new 
    
    end 

    def create 
        @user = User.find_by(username: params[:user][:username])
            #try is an active support method, calling try on the user, if the user is not nil, then they are authenticating the params password against what the user put in
            #before calling the method, it trys to see if the user is nil
        if @user.try(:authenticate, params[:user][:password])
            session[:user_id] = @user.id 
            redirect_to user_path(@user)
        # if @user && @user.authenticate(password: params[:user][:password])
        #     session[:user_id] = @user.id 
        #     #user_path(@user) is the same as user_path(user_id)
        #     redirect_to user_path(@user)
        else   
            #you need a flash error message to tell you if something went wrong
            flash[:error] = "Please try again. Username or Password was not correct"
            redirect_to login_path
        end 
    end 
end