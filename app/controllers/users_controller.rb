class UsersController < ApplicationController
  respond_to :html, :json

  def index
    if logged_in?
      respond_with current_user
    else
      respond_with "fail"
    end
  end

  def dashboard
  	@user = User.find(current_user.id)
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
    	flash[:success] = "Welcome to the Greenback!"
      redirect_to 'dashboard'
    else
      render 'dashboard'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
    	                           :password, :password_confirmation)
  end
end