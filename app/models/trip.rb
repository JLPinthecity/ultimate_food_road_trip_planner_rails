require 'pry'
class Trip < ApplicationRecord
    belongs_to :user
    has_many :eatery_trips                                         
    has_many :eateries, through: :eatery_trips, dependent: :destroy
    validates :title, :presence => true
    validates :description, :presence => true
   
  def eatery_trips_attributes=(attributes)
    attributes.values.each do |attribute|
      if attribute[:eatery_id].present? || attribute[:eatery_attributes].present?
        eatery_trip = EateryTrip.new(attribute)
        eatery_trip.trip = self 
        self.eatery_trips << eatery_trip 
      end
    end
  end
  
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














