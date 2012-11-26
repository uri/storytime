class UsersController < ApplicationController

  before_filter :check_current_user, :only => [:new, :create]

  def index
  end

  def new
    @user = User.new
  end

  def create
    respond_to do |format|
      puts params
      @user = User.new params[:user]
      
      if @user.save
        format.html do 
          session[:user_token] = @user.token
          redirect_to root_path
        end

        format.json
        format.xml
        
      else
        format.html { render "new" }
        format.json { render :json => { :errors => @user.errors.full_messages.to_json} }
        format.xml { render :xml => { :errors => @user.errors.full_messages.to_xml} }
      end

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