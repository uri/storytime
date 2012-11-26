class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_name params[:name]
    if user && user.authenticate(params[:password])
      user.update_token
      session[:user_token] = user.token
      puts "WEEEEB" * 100
      redirect_to root_path
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    signout
    redirect_to root_path
  end
end