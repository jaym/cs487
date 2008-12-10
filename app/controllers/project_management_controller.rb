class ProjectManagementController < ApplicationController
  before_filter :login_required
  before_filter :is_allowed
  def index
    @projects = @current_user.projects

  end

  def manage
    
    @project = Project.find_by_id(params[:id])
    if (in_project?(@project) == false)
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'index'
      return
    end


  end
  def new_test_plan
    p = Requirement.find(params[:rid]).project
    if (in_project?(p) == false || 
        (@current_user.role != 'Manager' && @current_user.role != 'Developer'))
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'manage', :id => p
      return
    end
    @test_plan = TestPlan.new
  end
  def add_test_plan
    p = Requirement.find(params[:rid]).project
    if (in_project?(p) == false || 
        (@current_user.role != 'Manager' && @current_user.role != 'Developer'))
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'manage', :id => p
      return
    end
    r = Requirement.find params[:rid]
    @test_plan = TestPlan.new params[:test_plan]
    
    if r.test_plans << @test_plan
      flash[:notice] = "Test plan added"
      redirect_to :action => 'edit_requirement', :rid => r
    else
      flash[:warning] = "Error adding test plan"
      render :action=>'new_test_plan'
    end
  end
  def delete_test_plan
    plan = TestPlan.find params[:tid]
    r = plan.requirement
    p = r.project
    if (in_project?(p) == false || 
        (@current_user.role != 'Manager' && @current_user.role != 'Developer'))
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'manage', :id => p
      return
    end
    plan.destroy
    redirect_to :action => 'edit_requirement', :rid => params[:rid] 
  end
  def new_requirement
    p = Project.find params[:pid]
    if (in_project?(p) == false || 
        (@current_user.role != 'Manager' && @current_user.role != 'Developer'))
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'manage', :id => p
      return
    end
    @requirement = Requirement.new
  end
  def add_requirement
    p = Project.find params[:pid]
    if(in_project?(p) == false || (@current_user.role != 'Manager' &&
       @current_user.role != 'Developer'))
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'manage', :id => p
      return
    end
    u = @current_user 

    @requirement = Requirement.new params[:requirement]

    if p.requirements << @requirement == false
      render :action => 'new_requirement'
    else
      redirect_to :action => 'manage', :id => params[:pid]
    end
  end
  def remove_requirement
    p = Project.find params[:pid] 
    if(in_project?(p) == false || @current_user.role != 'Manager')
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'manage', :id => p
      return
    end
    r = Requirement.find params[:rid]
    r.destroy
    redirect_to :action => 'manage', :id => params[:pid]
  end

  def new_feature
    p = Project.find params[:pid]
    if (in_project?(p) == false || (@current_user.role != 'Manager' &&
                                    @current_user.role != 'Customer'))
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'manage', :id => p
      return
    end
    @feature = Feature.new

  end
  def add_feature
    p = Project.find params[:pid]
    if (in_project?(p) == false || (@current_user.role != 'Manager' &&
                                    @current_uesr.role != 'Customer'))
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'index'
      return
    end
    u = @current_user 

    @feature = Feature.new params[:feature]
    @feature.user = @current_user 
    if p.features << @feature == false
      render :action => 'new_feature'
    else
      redirect_to :action => 'manage', :id => params[:pid]
    end
  end

  def remove_feature
    f = Feature.find params[:fid]
    p = Project.find params[:pid]
    if(in_project?(p) == false || (@current_user.role != 'Manager' && @current_uesr.role != f.user))
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'manage', :id => p
      return
    end
    fpr = f.feature_project_relationships.find_by_project_id p
    fpr.destroy
    redirect_to :action => 'manage', :id => params[:pid]
  end

  def edit_project
  end

  def edit_requirement
    @requirement = Requirement.find params[:rid] 
    p = @requirement.project
    if(in_project?(p) == false ||
      (@current_user.role != 'Manager' && @current_user.role != 'Developer'))
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'index'
      return
    end
  end

  def update_requirement
    @requirement = Requirement.find(params[:rid])
    p = @requirement.project
    if (in_project?(p) == false || (
      @current_user.role != 'Manager' && @current_user.role != 'Developer'))
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'index'
      return
    end
    flash[:notice] = flash[:warning] = nil
    
    if @requirement.update_attributes(params[:requirement])
      flash[:notice] = "Requirement successfully updated"
    else
      flash[:warning] = "Requirement was not updated"
    end
    render :action => 'edit_requirement'
  end
  
  def add_user
    p = Project.find params[:pid]
    if(in_project?(p) == false || @current_user.role != 'Manager') then
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'manage', :id => params[:pid]
      return
    end
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

    if in_project?(p) == false || @current_user.role != 'Manager'
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'index'
      return
    end
    
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
    if @current_user.role != 'Manager'
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'index'
      return
    end
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

    if (in_project?(@project) == false || @current_user.role != 'Manager')
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'index'
      return
    end
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
    if(in_project?(@project) || @current_user.role != 'Manager')
      flash[:warning] = 'You are not authorized to perform this action'
      redirect_to :action => 'index'
      return
    end
    if @project.close_date = Time.now and @project.save
      flash[:notice] = "Project Closed"
    else
      flash[:warning] = "Error closing project"
    end
    redirect_to :action => 'index' 
  end
  protected
  def in_project?(project)
    if project.users.find_index(@current_user) != nil
      return true
    end
    return false
  end
end
