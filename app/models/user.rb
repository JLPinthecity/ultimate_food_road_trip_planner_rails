class User < ApplicationRecord
  has_many :trip_users
  has_many :trips, through: :trip_users

  validates :name, :presence => true
  validates :email, :presence => true
  validates :email, :uniqueness => true

  has_secure_password

  def self.login_from_omniauth(auth)
    find_from_omniauth(auth) || create_from_omniauth(auth)
  end

  def self.find_from_omniauth(auth)
    find_by(:uid => auth[:uid])
  end

  def self.create_from_omniauth(auth)
    create(:uid => auth['uid'], 
           :name => auth['info']['name'],
           :email => auth['info']['email'],
           :image => auth['info']['image'], 
           :password => SecureRandom.hex(10))
  end

end
