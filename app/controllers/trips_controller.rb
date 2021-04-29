require 'pry'
class TripsController < ApplicationController
    before_action :verify_user, only: [:new, :create, :edit, :update, :destroy]  #all users may see itineraries but can't create or edit

    def new
      @user = current_user
      @trip = @user.trips.build
      5.times { @trip.eateries_trips.build.build_eatery }
      # 5.times { @trip.eateries.build }
      # @trip.eateries_trips.build
    end
   
    def create
      raise params.inspect
      find_user_by_id
      @trip = @user.trips.new(trip_params)
      if @trip.save
        redirect_to user_trip_path(@user, @trip)
      else
        render :new
      end
    end
  
    def show
       find_trip_by_id
       find_user_by_id
    end

    def index
      if params[:user_id]
        @trips = User.find(params[:user_id]).trips
      else
        @trips = Trip.all
      end
    end

    def edit
      find_user_by_id
      find_trip_by_id
    end

    def update
      find_trip_by_id
      if @trip.update(trip_params)
        redirect_to user_trip_path(current_user, @trip)
      else
        render :edit
      end
    end

    def destroy
      find_user_by_id
      @trip = @user.trips.find(params[:id])
      @trip.destroy
      redirect_to user_trips_path(@user)
    end
    
    private 

    def trip_params 
        params.require(:trip).permit(:title, :description, :eateries_attributes => [:city, :state, :name, :about, :food_categories, :dishes], 
                                     :eateries_trips_attributes => [:visit_date, :review])
    end

    def find_trip_by_id
      @trip = Trip.find(params[:id])
    end

    def find_user_by_id
      @user = User.find(params[:user_id])
    end
    
end