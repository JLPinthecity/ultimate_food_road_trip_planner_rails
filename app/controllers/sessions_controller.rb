require 'pry'
class SessionsController < ApplicationController

    def new
    end

    def create
      if params[:email].present? || params[:password].present? 
        user = User.find_by(:email => params[:email])
        if user && user.authenticate(params[:password])
            login(user)
            redirect_to root_path
            flash[:notice] = "Successfully logged in."                       
        else
            redirect_to login_path
            flash[:notice] = "Email and/or password were not a match."        
        end
      else
        auth.present?
        user = User.login_from_omniauth(auth)
        login(user)
        redirect_to root_path
        flash[:notice] = "Successfully logged in with Facebook."              
      end
    end

    def destroy
        session.delete(:user_id)
        flash[:notice] = "Successfully logged out."                           
        redirect_to root_path
    end

    private 

    def auth
        request.env['omniauth.auth']
    end
end