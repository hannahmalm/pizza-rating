class ApplicationController < ActionController::Base

    helper_method :current_user, :not_logged_in_helper, :logged_in?
    #if you do not define this up here as a helper method you cant use it in forms

    private 

    def current_user #this method needs to return user that is found by session user id
        #||= will only call db once if you are using current user more than once in a method 
        #find by id so that if the id is null it wont error out
        @current_user ||= User.find_by_id(session[:user_id]) 
    end 

    def logged_in? #will return boolean t/f, if nil it will return false
        !!current_user
    end 

    def not_logged_in_helper #this is the same as if logged_in? else redirect to login
        if !current_user
            redirect to login_path
        end 
    end 

end
