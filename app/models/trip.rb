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

            trip_hash[:destinations].each do |destination|
              a = trip.destinations.where(:city => destination[:city]).first_or_create(:city => destination[:city], :state => destination[:state])
               
              b = a.eateries.new(:name => destination[:eateries][:name], :food_categories => destination[:eateries][:food_categories],
                :about => destination[:eateries][:about], :dishes => destination[:eateries][:dishes]) 
              b.save 

            end                            
        end
    end

    # def destinations_attributes=(destinations_attributes)
        # trip: {
        #     destinations_attributes: {
        #       city: '',
        #       state: ''
        #     }
    # end
end