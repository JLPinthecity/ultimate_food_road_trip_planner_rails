class Eatery < ApplicationRecord
    has_many :eatery_trips                                         
    has_many :trips, through: :eatery_trips, dependent: :destroy   
    
    # validates :city, :presence => true
    # validates :state, :presence => true
    # validates :name, :presence => true
    # validates :about, :presence => true
    # validates :food_categories, :presence => true
    # validates :dishes, :presence => true

    def location
        "#{self.city}, #{self.state}"
    end

end
