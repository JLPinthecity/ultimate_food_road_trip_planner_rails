class User < ApplicationRecord
    has_many :trip_users
    has_many :trips, through: :trip_users

    validates :email, :presence => true
    validates :email, :unique => true
end
