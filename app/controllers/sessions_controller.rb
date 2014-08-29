class SessionsController < ApplicationController
  before_action :ensure_logged_in, only: [:destroy]

  def new
  end

  def create
    user = User.find_by_credentials(
      params[:username], params[:password]
    )
    
    if user
      login_user!(user)
    else
      flash.now[:errors] = ["User/password combination not found"]
      render :new
    end
  end

  def destroy
    logout_user!(current_user)
  end
end
