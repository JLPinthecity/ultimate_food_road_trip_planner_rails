class ApplicationController < ActionController::Base
    helper_method :current_user, :login, :logged_in?, :verified_user 

    def current_user 
        @current_user ||= User.find_by(:id => session[:user_id]) if session[:user_id]
    end

    def login(user)
        session[:user_id] = user.id
    end

    def logged_in?
        !!current_user
    end

    def verified_user
        redirect_to root_path unless logged_in
    end

end
