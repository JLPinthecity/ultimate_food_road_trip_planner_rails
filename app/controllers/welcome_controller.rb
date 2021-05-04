require 'pry'
class WelcomeController < ApplicationController

    def home
      if logged_in?
        @user = User.find(session[:user_id])
      end
    end

    def about
    end

end