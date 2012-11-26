class UsersController < ApplicationController

  before_filter :check_current_user, :only => [:new, :create]

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    
    if @user.save
      session[:user_token] = @user.token
      redirect_to root_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def check_current_user
    redirect_to root_path unless current_user.nil?
  end

end