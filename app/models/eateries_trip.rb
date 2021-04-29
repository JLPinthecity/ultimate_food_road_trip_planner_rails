class EateriesTrip < ApplicationRecord
    belongs_to :eatery
    belongs_to :trip 

    validates_uniqueness_of :eatery_id, scope: [:trip_id]

    scope :completed, -> { where(completed: true) }
    scope :not_completed, -> { where(completed: false) }
end
