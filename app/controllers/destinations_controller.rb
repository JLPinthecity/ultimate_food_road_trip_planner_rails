class DestinationsController < ApplicationController

    private 

    def destination_params 
        params.require(:destination).permit(:city, :state)
    end
end