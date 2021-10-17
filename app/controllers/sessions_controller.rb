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

        if params[:provider] == 'google_oauth2'
            @user = User.find_or_create_by_google(auth_hash) #this method is in user model
            session[:user_id] = @user.id 
            redirect_to user_path(@user)
        elsif params[:provider] == 'github'
            @user = User.find_or_create_by_github(auth_hash) #this method is in user model
            session[:user_id] = @user.id 
            redirect_to user_path(@user)
        else 
            @user = User.find_by(username: params[:user][:username])
            #try is an active support method, calling try on the user, if the user is not nil, then they are authenticating the params password against what the user put in
            #before calling the method, it trys to see if the user is nil. If user is not nil, it will authenticate
            if @user.try(:authenticate, params[:user][:password])
            # if @user && @user.authenticate(password: params[:user][:password])
                session[:user_id] = @user.id #set the session 
                redirect_to user_path(@user) #user_path(@user) is the same as user_path(user_id)
            else   
                flash[:error] = "Please try again. Username or Password was not correct" #tell the user if login failed - Add this into login form view
                redirect_to login_path #redirect the user to the login page
            end 
        end 
    end 

    def omniauth 
        #find or create the user via the email, then set the password 
        @user = User.find_or_create_by_google(auth_hash)
        @user = User.find_or_create_by_github(auth_hash)
        #After password is set, they log in, session is set, they are redirected to user path 
        session[:user_id] = @user.id
        redirect_to user_path(@user) #same as /user/:id 


        #run Rails c - request.env['omniauth.auth'][':info'][':email']
        #User.where(username: auth[:info][:email]).first_or_initialize #looks in db for email, if email exists(first result), authorize it, if not initialize it
 
    end 

    private 

        def auth_hash #will return the request .env
            request.env['omniauth.auth']
        end 

end