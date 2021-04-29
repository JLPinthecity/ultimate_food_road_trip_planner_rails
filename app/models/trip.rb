require 'pry'
class Trip < ApplicationRecord
    has_many :eateries_trips                                         
    has_many :eateries, through: :eateries_trips

    validates :title, :presence => true
    validates :description, :presence => true

    accepts_nested_attributes_for :eateries_trips, allow_destroy: true
   
    def self.create_from_collection(trips) #for scraper
        u = User.find_by(:name => "Admin")
        trips.each do |trip_hash|  
          trip = u.trips.create(:title => trip_hash[:title], :description => trip_hash[:description])

            trip_hash[:eateries].each do |eatery|
                a = trip.eateries.create(:name => eatery[:name], :city => eatery[:city], :state => eatery[:state], :food_categories => eatery[:food_categories],
                                     :about => eatery[:about], :dishes => eatery[:dishes])
            end         
        end
    end

    # def find_or_create_eatery
    #   self.eateries.each do |eatery|
    #     eatery.name = Eatery.find_or_create_by(:name => eatery.name)
    #   end
    # end

end








    #   eateries_attributes = [
        #        {:city => "",
        #         :state => "",
        #         :name => "",
        #         :food_categories => "",
        #         :dishes => ""
        #       } 
        #         {:city => "",
        #         :state => "",
        #         :name => "",
        #         :food_categories => "",
        #        :dishes => ""
        #       } 
        #     ]
