class Eatery < ApplicationRecord
    has_many :eateries_trips                                         
    has_many :trips, through: :eateries_trips    

    def location
        "#{self.city}, #{self.state}"
    end
end
