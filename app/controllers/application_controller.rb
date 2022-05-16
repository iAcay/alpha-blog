class ApplicationController < ActionController::Base

  helper_method :current_user
  helper_method :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    redirect_to login_path, notice: 'You must be logged in.' if !logged_in?
  end
end
