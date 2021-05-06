require 'pry'
class Trip < ApplicationRecord
    belongs_to :user
    has_many :eatery_trips                                         
    has_many :eateries, through: :eatery_trips, dependent: :destroy
    validates :title, :presence => true
    validates :description, :presence => true

    accepts_nested_attributes_for :eatery_trips
   
  # def eatery_trips_attributes=(attributes)
  #   attributes.values.each do |attribute|
  #     if attribute[:eatery_id].present? #eatery exists
  #       eatery_trip = EateryTrip.new(attribute)
  #       eatery_trip.trip = self 
  #       eatery_trip.eatery = Eatery.find(attribute[:eatery_id].to_i)
  #       self.eatery_trips << eatery_trip
  #     else
  #       eatery_trip = EateryTrip.new(attribute)
  #       eatery_trip.trip = self 
  #       eatery_trip.save
  #     end

  #   end
  # end
  
  #self.eatery_trips.build(attribute) error moves to update with this line

  def self.create_from_collection(trips) #for scraper
    u = User.find_by(:name => "Admin")
      trips.each do |trip_hash|  
        binding.pry
        trip = u.trips.create(:title => trip_hash[:title], :description => trip_hash[:description])
          trip_hash[:eateries].each do |eatery|
              a = trip.eateries.create(:name => eatery[:name], :city => eatery[:city], :state => eatery[:state], :food_categories => eatery[:food_categories],
                                   :about => eatery[:about], :dishes => eatery[:dishes])
          end      
      end
    end
end














