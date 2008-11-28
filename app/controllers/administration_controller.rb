class AdministrationController < ApplicationController
  def index
    
  end
  def view_users
    @users = User.find(:all)
  end

  def view_projects
    @projects = Project.find(:all)
  end

  def new_user
    @user = User.new
  end

  def create_user
    params[:user]["username"].downcase!
    params[:user]["username"].strip
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'User was successfully added'
      redirect_to :action => 'view_users'
    else
      render :action => "new_user"
    end
  end
  def delete_project
    @project = Project.find(params[:id])
    if @project.close_date then
      @project.destroy
      flash[:notice] = "Project has been removed"
    else
      flash[:warning] = "Cannot remove a project that is open"
    end
    redirect_to :action => "view_projects"
  end

  def edit_user
    @user = User.find(params[:id])
  end

  def update_user
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "User successfully updated"
      redirect_to :action => "view_users"
    else
      render :action => 'edit_user' 
    end
  end

  def delete_user
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User has been removed"
    redirect_to :action => "view_users"
  end

end
