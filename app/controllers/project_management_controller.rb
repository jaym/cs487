class ProjectManagementController < ApplicationController
  before_filter :login_required
  before_filter :is_manager
  def index
    @projects = @current_user.projects
  end

  def show_project
  end

  def edit_project
  end
  
  def new_project
    @project = Project.new
  end

  def create_project
  end

  def crud_user
  end
  def destroy
    @project = Project.find(params[:id])
    if @project.close_date
      @project.destroy
      flash[:notice] = "Project Deleted"
    else
      flash[:warning] = "Cannot delete an open project"
    end
      redirect_to :action => 'index'
  end
  def close_project
    @project = Project.find(params[:id])
    if @project.close_date = Time.now and @project.save
      flash[:notice] = "Project Closed"
    else
      flash[:warning] = "Error closing project"
    end
    redirect_to :action => 'index' 
  end

end
