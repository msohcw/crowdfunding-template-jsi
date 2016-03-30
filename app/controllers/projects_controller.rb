class ProjectsController < ApplicationController
  def index
    # @projects = Project.all
  	@active_projects = Project.where('expires > :now', :now => Time.now)
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
  	@project = current_user.projects.build
  end
  
  def create
    # @project = current_user.projects.build(project_params.merge(:expires => 20.seconds.from_now))
    # @project = current_user.projects.build(project_params.merge(:expires => 10.minutes.from_now))
    # @project = current_user.projects.build(project_params.merge(:expires => 30.minutes.from_now))
  	@project = current_user.projects.build(project_params.merge(:expires => 1.hour.from_now))
  	if @project.save
  		flash[:success] = "Project created."
      # Resque.enqueue_in(5.minutes, ChargeBackersJob, project_id: @project.id)
      ChargeBackersJob.new(@project).enqueue(wait_until: @project.expires)
  	else
  		flash[:failure] = "Unable to create project."
  	end
  	redirect_to root_url
  end 

  protected
    def project_params
    	params.require(:project).permit(:name, :description, :target)
    end
end