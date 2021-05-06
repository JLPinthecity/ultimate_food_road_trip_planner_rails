require 'pry'
class EateryTrip < ApplicationRecord
  belongs_to :trip 
  belongs_to :eatery

<<<<<<< HEAD
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
=======
    scope :visited, -> { where("visit_date < ?",Time.now ) } 

    def eatery_attributes=(attributes)
      eatery = Eatery.find_or_create_by(attributes)
      self.eatery_id = eatery.id
    end
>>>>>>> dc0c3600a66dcc771d86b9e5de25c4d43e88fe23

  def format_date
    self.visit_date.strftime("%B %d, %Y")
  end

end
