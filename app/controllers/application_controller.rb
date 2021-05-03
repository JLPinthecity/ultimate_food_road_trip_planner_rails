class ApplicationController < ActionController::Base
    helper_method :current_user, :user_match?, :login, :logged_in?, :verify_user 
    
    def current_user 
        @current_user ||= User.find_by(:id => session[:user_id]) if session[:user_id]
    end

    def user_match?
        current_user.id == @user.id
    end

    def login(user)
        session[:user_id] = user.id
    end

    def logged_in?
        !!current_user
    end

    def verify_user
        redirect_to root_path unless logged_in?
    end

end
