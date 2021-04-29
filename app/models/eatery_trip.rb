class EateryTrip < ApplicationRecord
    belongs_to :eatery
    belongs_to :trip 

    validates_uniqueness_of :eatery_id, scope: [:trip_id]

    accepts_nested_attributes_for :eatery

    scope :visited, -> { where('visit_date IS NOT ? AND visit_date != ?', nil, '') }
    scope :reviewed, -> { where('reviewed IS NOT ? AND reviewed != ?', nil, '') }

    def visit_date_exists
      self.visit_date != "nil" || ""
    end

    def review_exists
      self.eatery_trip.review != "nil" || "" 
    end
end
