require 'pry'
class TripsController < ApplicationController
    before_action :verify_user, only: [:destroy]  

    def new
      @user = current_user
      @trip = @user.trips.build
      @trip.eateries.build
    end

    def create
      raise params.inspect   #need to update strong params

        @trip = Trip.new(trip_params)
        if @trip.save
          redirect to trip_path(@trip) #trips/#trip.id
        else
          render :new
        end
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
        params.require(:trip).permit(:title, :description, )
    end


end