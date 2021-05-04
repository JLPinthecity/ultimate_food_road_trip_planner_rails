class UsersController < ApplicationController
  before_action :verify_user, only: [:show]

  def new
    @user = User.new
  end 

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      login(@user)
      redirect_to root_path
      flash[:notice] = "Account successfully created."     #works
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @trips = @user.trips
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end