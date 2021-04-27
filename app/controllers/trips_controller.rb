require 'pry'
class TripsController < ApplicationController
    before_action :verify_user, only: [:new, :create, :edit, :update, :destroy]  #all users may see itineraries

    def new
      find_user_by_id
      @trip = Trip.new
      5.times { @trip.eateries.build }
    end
   
    def create
      find_user_by_id
      @trip = @user.trips.new(trip_params)
      if @trip.save
        redirect_to user_trips_path(@user, @trip)
      else
        redirect_to new_user_trip_path(@user)
      end
    end
  
    def show
       find_trip_by_id
    end

    def index
      if params[:user_id]
        @trips = User.find(params[:user_id]).posts
      else
        @trips = Trip.all
      end
    end

    def edit
      find_trip_by_id
    end

    def update
      find_trip_by_id
    end

    def destroy
    end

    private 

    def trip_params 
        params.require(:trip).permit(:title, :description, :eateries_attributes => [:city, :state, :name, :about, :food_categories, :dishes])
    end

    def find_trip_by_id
      @trip = Trip.find_by(id: params[:id])
    end

    def find_user_by_id
      @user = User.find(params[:user_id])
    end
    
end