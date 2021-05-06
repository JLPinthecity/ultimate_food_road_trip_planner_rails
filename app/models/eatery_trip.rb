require 'pry'
class EateryTrip < ApplicationRecord
    belongs_to :eatery
    belongs_to :trip 

    scope :visited, -> { where("visit_date < ?",Time.now ) } 

    def eatery_attributes=(attributes)
      eatery = Eatery.find_or_create_by(attributes)
      self.eatery_id = eatery.id
    end

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
