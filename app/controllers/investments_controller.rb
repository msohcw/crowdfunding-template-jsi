class InvestmentsController < ApplicationController
	def new
		@investment = Investment.new
		@project = params[:project_id]
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
	
  protected

  def investment_params
		params.require(:investment).permit(:amount, :project_id)
  end
end