require 'pry'
class EateryTrip < ApplicationRecord
    belongs_to :eatery
    belongs_to :trip 

    validates_uniqueness_of :eatery_id, scope: [:trip_id]

    accepts_nested_attributes_for :eatery

    scope :visited, -> { where("visit_date < ?",Time.now ) } 

    def visit_date_exists
      self.visit_date.present?
    end

    def review_exists
      self.review.present?
    end

    def format_date
      self.visit_date.strftime("%B %d, %Y")
    end
end
