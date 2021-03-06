class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  def login_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    
    redirect_to user_url(user)
  end
  
  def logout_user!(user)
    session[:session_token] = nil
    
    redirect_to new_session_url
  end
  
  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end
  
  def logged_in?
    !!current_user
  end
  
  def ensure_logged_in
    redirect_to user_url(current_user) unless logged_in?
  end
  
  def ensure_not_logged_in
    redirect_to user_url(current_user) if logged_in?
  end
end
