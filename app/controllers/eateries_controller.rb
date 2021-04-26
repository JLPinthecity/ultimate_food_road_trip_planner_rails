class EateriesController < ApplicationController

    private 

    def eatery_params 
        params.require(:eatery).permit(:name, :food_categories, :about, :dishes)
    end
end