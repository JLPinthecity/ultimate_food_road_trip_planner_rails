require 'pry'
class TripsController < ApplicationController
    before_action :verify_user, only: [:destroy]  

    def new
      @user = current_user
      @trip = @user.trips.build
      @trip.destinations.build
     
     
    end

    def show
       @trip = Trip.find_by(id: params[:id])
    end

    def index
        @trips = Trip.all
    end

    def update
    end

    def destroy
    end

    private 

    def trip_params 
        params.require(:trip).permit(:title, :description)
    end


end