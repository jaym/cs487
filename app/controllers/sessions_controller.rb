require 'digest/sha1'
class SessionsController < ApplicationController
  def new
  end

  def create
      @current_user = User.authenticate(params[:login], 
                                          params[:password])
    if @current_user
      session[:user_id] = @current_user.id
      if @current_user.role == "Admin"
        redirect_to :controller => "Administration" 
      elsif @current_user.role == "Manager"
        redirect_to :controller => "ProjectManagement"
      else
        redirect_to :controller => "UserManagement"
      end
    else
      flash[:warning] = "Incorrect login"
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = @current_user = nil
  end

end
