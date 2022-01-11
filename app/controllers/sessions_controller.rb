class SessionsController < ApplicationController
    def index #GET / sessions#index - Action Method
        #Implicitly renders sessions/index.html.erb
    end 

    def destroy #logout DELETE /logout(.:format) sessions#destroy 
        #the logout link/button should be within the layouts page
        session.delete(:user_id)  #in rails use delete instead of destroy - destroy is the preferred command when deleting objects, not sessions
        redirect_to '/'
    end 

    def new #GET /login - login action
        #implicitly renders the sessions/new.html.erb file 
    end 

    def create #POST /login sessions#create
        if params[:provider] == 'google_oauth2' #defined in initilizers/omniauth.rb
            @user = User.find_or_create_by_google(auth_hash) #method within the user model, params in private method
            session[:user_id] = @user.id #set the session id
            redirect_to user_path(@user) #redirect to the user homepage
        else 
            @user = User.find_by(username: params[:user][:username]) #use this via regular sign  in
            #try is an active support method, calling try on the user, if the user is not nil, then they are authenticating the params password against what the user put in
            #before calling the method, it trys to see if the user is nil. If user is not nil, it will authenticate.
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
        @user = User.find_or_create_by_google(auth_hash)  #find or create the user via the email, then set the password 
        session[:user_id] = @user.id #After password is set, they log in, session is set, they are redirected to user path 
        redirect_to user_path(@user) #same as /user/:id - redirect to user homepage
        #run Rails c - request.env['omniauth.auth'][':info'][':email']
        #User.where(username: auth[:info][:email]).first_or_initialize #looks in db for email, if email exists(first result), authorize it, if not initialize it    
    end 

    private 

    #The omniauth.auth key in the environment hash provides an Authentication Hash which will contain information about the user including a unique id, 
    #the strategy they just used for authentication, and personal details such as name
        def auth_hash 
            request.env['omniauth.auth']
        end 

end