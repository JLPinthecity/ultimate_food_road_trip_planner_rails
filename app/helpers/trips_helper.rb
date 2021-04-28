require 'pry'
module TripsHelper

    def user_match?
        current_user.id == @user.id
    end
end
