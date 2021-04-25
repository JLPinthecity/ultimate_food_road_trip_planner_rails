class Destination < ApplicationRecord
    has_many :trip_destinations
    has_many :trips, through: :trip_destinations
    has_many :eateries

    validates :city, :presence => true
    validates :state, :presence => true
end
