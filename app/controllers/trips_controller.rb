class TripsController < ApplicationController
    before_action :verify_user, only: [:new, :edit, :update, :destroy]  

    def new
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