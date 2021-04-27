require 'pry'
class TripsController < ApplicationController
    before_action :verify_user, only: [:new, :create, :edit, :update, :destroy]  #all users may see itineraries

    def new
      @trip = Trip.new
      5.times { @trip.eateries.build }
    end
   
    def create
        @user = current_user
        @trip = @user.trips.build(trip_params)
        if @trip.save
          redirect_to user_trip_path(@user, @trip) #/users/:user_id/trips/:id
        else
          render :new
        end
    end

    def show
       find_trip_by_id
    end

    def index
        @trips = Trip.all
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


end