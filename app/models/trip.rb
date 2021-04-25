require 'pry'
class Trip < ApplicationRecord
    has_many :trip_destinations,  dependent: :destroy
    has_many :destinations, through:  :trip_destinations
    has_many :trip_users,  dependent: :destroy
    has_many :users, through: :trip_users  

    def self.create_from_collection(trips)
        trips.each do |trip_hash|
            
          trip = Trip.create
          trip.title = trip_hash[:title]
          trip.description = trip_hash[:description]

          trip_hash[:destinations].each do |destination|
            a = trip.destinations.create(:city => destination[:city], :state => destination[:state])

            e = Eatery.new(:name => destination[:eateries][:name], :food_categories => destination[:eateries][:food_categories],
                              :about => destination[:eateries][:about], :dishes => destination[:eateries][:dishes])
            

            binding.pry
          
          end
                               
        end
    end
end
