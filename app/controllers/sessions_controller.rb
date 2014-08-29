class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_credentials(
      params[:username], params[:password]
    )
    
    if user
      login_user!(user)
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def destroy
    logout_user!(current_user)
  end
end
