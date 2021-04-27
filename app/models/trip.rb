require 'pry'
class Trip < ApplicationRecord
    has_many :eateries_trips                                         
    has_many :eateries, through: :eateries_trips

    validates :title, :presence => true
    validates :description, :presence => true

    accepts_nested_attributes_for :eateries
   
    def self.create_from_collection(trips) #for scraper
        trips.each do |trip_hash| 
          trip = Trip.create(:title => trip_hash[:title], :description => trip_hash[:description])

            trip_hash[:eateries].each do |eatery|
                a = trip.eateries.create(:name => eatery[:name], :city => eatery[:city], :state => eatery[:state], :food_categories => eatery[:food_categories],
                                     :about => eatery[:about], :dishes => eatery[:dishes])
            end         
        end
    end
end