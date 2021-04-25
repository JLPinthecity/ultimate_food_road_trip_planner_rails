require 'pry'
class SessionsController < ApplicationController

    def new
    end

    def create
      if params[:email].present? && params[:password].present? 
        user = User.find_by(:email => params[:email])
        if user && user.authenticate(params[:password)]
            login(user)
            redirect_to root_path
            flash[:notice] = "Successfully logged in."
        else
            flash.now[:notice] = "Email or password not a match."
            render :new
        end
      else
        #log in with FB
        auth.present?
        user = User.login_from_omniauth(auth)
        login(user)
        redirect_to root_path
      end
    end

    def destroy
    end

    private 

    def auth
        request.env['omniauth.auth']
    end
end