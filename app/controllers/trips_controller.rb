require 'pry'
class TripsController < ApplicationController
    before_action :verify_user, except: [:show, :index]
    before_action :find_user_by_id, except: [:new, :index]
    before_action :find_trip_by_id, only: [:show, :edit, :update]

    def new
      @user = current_user
      @trip = @user.trips.build
      2.times { @eaterytrips = @trip.eatery_trips.build }
      2.times { @eatery = @eaterytrips.build_eatery }
    end
   
    def create
      @trip = Trip.new(trip_params)
      if @trip.save
        redirect_to user_trip_path(@user, @trip)
      else
        render :new 
      end
    end
  
    def show
    end

    def index
      if params[:user_id]
        @trips = User.find(params[:user_id]).trips
      else
        @trips = Trip.all
      end
    end

    def edit
    end

    def update
      if @trip.update(trip_params)
        redirect_to user_trip_path(current_user, @trip)
      else
        render :edit
      end
    end

    def destroy
      @trip = @user.trips.find(params[:id])
      @trip.destroy
      redirect_to user_trips_path(@user)
    end
    
    private 

    def trip_params 
        params.require(:trip).permit(:id, :title, :description, :eatery_trips_attributes => [:id, :visit_date, :review, :eatery_id, :eatery_attributes => [:id, :city, :state, :name, :about, :food_categories, :dishes]])
    end

    def find_trip_by_id
      @trip = Trip.find(params[:id])
    end

    def find_user_by_id
      @user = User.find(params[:user_id])
    end
    
end



