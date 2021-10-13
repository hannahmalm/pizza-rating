class SessionsController < ApplicationController
    def index 
    end 

    def new 
        @user = User.new
    end 

    def destroy 
        #the logout link/button should be within the layouts page
        #in rails use delete instead of destroy - destroy is the preferred command when deleting objects, not sessions
        session.delete(:user_id)
        redirect to '/'
    end 
end