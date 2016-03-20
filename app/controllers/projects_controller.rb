class ProjectsController < ApplicationController
  def index
  	@projects = Project.all
  end

  def new
  	@project = current_user.projects.build
  end
  
  def create
  	@project = current_user.projects.build(project_params.merge(:expires => 1.minute.from_now))
  	if @project.save
  		flash[:success] = "Project created."
  	else
  		flash[:failure] = "Unable to create project."
  	end
  	redirect_to root_url
  end 

  private

    def project_params
    	params.require(:project).permit(:name, :description, :target)
    end
end