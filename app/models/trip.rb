require 'pry'
class Trip < ApplicationRecord
    has_many :trip_destinations,  dependent: :destroy
    has_many :destinations, through:  :trip_destinations
    has_many :trip_users,  dependent: :destroy
    has_many :users, through: :trip_users  

    def self.create_from_collection(trips)
        trips.each do |trip_hash|
            binding.pry
          trip = Trip.new
          trip.title = trip_hash[:title]
          trip.description = trip_hash[:description]
          trip.destinations

        end
    end
end
