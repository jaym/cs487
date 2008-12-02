class ProjectManagementController < ApplicationController
  before_filter :login_required
  before_filter :is_manager
  def index
    @projects = @current_user.projects

  end

  def manage
    
    @project = Project.find_by_id(params[:id])
    
    if @project.users.find_index(@current_user) != nil
      print "test"
    else
      flash[:warning] = 'You are not authorized to manage this project'
      redirect_to :action => 'index'
    end

  end

  def add_requirement

  end
  def remove_requirement

  end
  def add_feature

  end
  def remove_feature

  end

  def edit_project
  end
  
  def add_user

    p = Project.find params[:pid]
    u = User.find params[:id]
    if p.users.find_index(u) == nil
      u.projects << p
      flash[:notice] = "User has been added to project."
    else
      flash[:warning] = "User is already in this project."
    end
    redirect_to :action => 'manage', :id => params[:pid]
  end
  
  def delete_user
    p = Project.find params[:pid]
    u = User.find params[:id]
    i = p.users.find_index(u)
    if i == nil
      flash[:notice] = "User is not in this project"
    else
      upr = u.user_project_relationship.find_by_project_id p
      upr.destroy
      flash[:notice] = "User has been removed from the project"
    end
    redirect_to :action => 'manage', :id => params[:pid]
  end
  
  def new_project
    @project = Project.new
  end

  def create_project
    @project = Project.new(params[:project])
    @project.open_date = Time.now
    @project.users << @current_user 
    if @project.save
      flash[:notice] = "New project created."
      redirect_to :action => 'index' 
    else
      render :action => 'new_project'
    end

  end

  def crud_user

    @project = Project.find_by_id(params[:pid])
    unless params[:query].nil?
      @query = params[:query]
      condition = ["username LIKE ? OR first_name LIKE ? OR last_name LIKE ?",
      "#{params[:query]}","#{params[:query]}","#{params[:query]}"] unless params[:query].nil?
      @query = condition
      @users = User.find(:all, :conditions => condition)
      raise "Assertion failed !" unless @project != nil
    else
      @users = User.find(:all)
    end
    params[:pid] = @project
    if request.xml_http_request?
      render :partial => "users_list", :layout => false 
    end
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
