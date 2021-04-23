class Trip < ApplicationRecord
    has_many :trip_destinations,  dependent: :destroy
    has_many :destinations, :through  :trip_destinations
    has_many :trip_users,  dependent: :destroy
    has_many :users, :through :trip_users  

end
