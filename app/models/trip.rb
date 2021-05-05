require 'pry'
class Trip < ApplicationRecord
    has_many :eatery_trips                                         
    has_many :eateries, through: :eatery_trips, dependent: :destroy

    validates :title, :presence => true
    validates :description, :presence => true
   


    def eatery_trips_attributes=(attributes)
      attributes.values.each do |attribute|
        #if attribute of eater_id is found/not blank, find create eatery_new with existing eatery
        #else if att of eatery_id is not found/blank, create with custom eatery

        

      end


    end

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

  # params.require(:trip).permit(:id, :title, :description, :eatery_trips_attributes => [:id, :visit_date, :review, :eatery_id, :eatery_attributes => [:id, :city, :state, :name, :about, :food_categories, :dishes]])













