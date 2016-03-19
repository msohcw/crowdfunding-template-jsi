class InvestmentsController < ApplicationController
	def new
		@project = params[:project_id]
		@invested = Investment.find_by(user_id: current_user.id, project_id: @project)
		@investment = Investment.new

		if @invested.present?
			@investment = @invested.amount
			@invested = true
		else
			@invested = false
		end
	end

	def create
		@investment = current_user.investments.build(investment_params)

		if @investment.save
			flash[:success] = "Project backed for #{@investment.amount}"
			@investment.project.calculate_raised
		else
			flash[:failure] = "Error in backing project."
		end

		redirect_to root_url
	end

	def edit
		@investment = current_user.investments.find(params[:id])
		unless @investment.present? 
			redirect_to new_investment_path(project: params[:project_id])
		end
		@project = @investment.project_id
	end

	def update
		@investment = current_user.investments.find(params[:id])
		@project = Project.find(@investment.project_id)
		if @investment.present? and @investment.update_attribute(:amount, investment_params[:amount])
			# flash[:success] = "Project backing changed to #{@investment.amount}"
			# @investment.project.calculate_raised
			render 'pledge'
		else
			flash[:failure] = "Error in backing project."
			render 'edit'
		end
	end

	def pledge
	end
	
  protected

  def investment_params
		params.require(:investment).permit(:amount, :project_id)
  end
end