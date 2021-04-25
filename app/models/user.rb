class User < ApplicationRecord
    has_many :trip_users
    has_many :trips, through: :trip_users
    validates :name, :presence => true, :message => "Please include your name."
    validates :email, :presence => true, :message => "Please enter your email."
    validates :email, :uniqueness => true, :message => "Email already exists."




end
