class UsersController < ApplicationController
  before_action :ensure_logged_in, except: [:show]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      login_user!(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def show
    show_user
  end
  
  private
  
  def show_user
    @user ||= User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
