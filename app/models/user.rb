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
    find_by(:uid => auth[:uid], :provider => auth[:provider])
  end


    

    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
  end
  session[:user_id] = @user.id
  redirect_to root_path
  flash[:notice] = "You have successfully logged in."


end
