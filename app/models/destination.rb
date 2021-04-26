require 'pry'
class Destination < ApplicationRecord
    has_many :trip_destinations
    has_many :trips, through: :trip_destinations
    has_many :eateries

    validates :city, :presence => true
    validates :state, :presence => true

    accepts_nested_attributes_for :eateries

    def location
        "#{self.city}, #{self.state}"
    end
end
