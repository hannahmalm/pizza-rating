class SessionsController < ApplicationController
    def index 
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
            session[:user_id] = @user.id 
            redirect_to user_path(@user)
        # if @user && @user.authenticate(password: params[:user][:password])
        #     session[:user_id] = @user.id 
        #     #user_path(@user) is the same as user_path(user_id)
        #     redirect_to user_path(@user)
        # else   
        #     redirect_to '/'
        #     #redirect_to login_path
        # end 
    end 
end