class ApplicationController < ActionController::Base

    helper_method :current_user
    #if you do not define this up here as a helper method you cant use it in forms

    private 

    def current_user #this method needs to return user that is found by session user id
        #||= will only call db once if you are using current user more than once in a method 
        #find by id so that if the id is null it wont error out
        @current_user ||= User.find_by_id(session[:user_id]) 
    end 

end
