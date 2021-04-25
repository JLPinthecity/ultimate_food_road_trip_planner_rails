class User < ApplicationRecord
  has_many :trip_users
  has_many :trips, through: :trip_users

  validates :name, :presence => true
  validates :email, :presence => true
  validates :email, :uniqueness => true

  has_secure_password


end
