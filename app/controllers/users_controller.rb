class UsersController < ApplicationController


  def new
    @user = User.new
  end 

  def create
    @user = User.new(user_params)
    if @user
      @user.save
      login(@user)
      redirect_to root_path
      flash[:notice] = "Successfully logged in."
    else
      render :new
      flash[:notice] = "Please try again."
    end
      
       
   

  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end