class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def current_user
    @current_user ||= User.find_by_token(session[:user_token]) if session[:user_token]
  end

  def signout
    @current_user = nil
    session[:user_token] = nil
  end

  def signed_in?
    !!session[:user_token]
  end

  helper_method :current_user
  helper_method :signed_in?
  helper_method :signout
end
