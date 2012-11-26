class SessionsController < ApplicationController

  def new
  end

  def create
    respond_to do |format|
      puts params
      @user = User.find_by_name params[:name]
      if @user && @user.authenticate(params[:password])
        @user.update_token

        format.html do
          session[:user_token] = @user.token
          redirect_to root_path
        end

        format.json
        format.xml
      else
        format.html do
          flash.now.alert = "Invalid email or password"
          render "new"
        end

        error_hash = {:error => "username or password is incorrect"}
        format.json { render :json => error_hash }
        format.xml { render :xml => error_hash }
      end


    end

  end

  def destroy
    signout
    # maybe destroy token
    redirect_to root_path
  end
end