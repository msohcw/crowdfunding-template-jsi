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
			redirect_to "/pledge/#{@investment.id}"
		else
			flash[:failure] = "Error in backing project."
			render 'edit'
		end
	end

	def edit
		@investment = current_user.investments.find(params[:id])
		@project = @investment.project_id

		unless @investment.present? 
			redirect_to new_investment_path(project: params[:project_id])
		end
	end

	def update
		@investment = current_user.investments.find(params[:id])
		@project = Project.find(@investment.project_id)
		if @investment.present? and @investment.update_attribute(:amount, investment_params[:amount])
			# render 'pledge'
			redirect_to "/pledge/#{params[:id]}"
		else
			flash[:failure] = "Error in backing project."
			render 'edit'
		end
	end

	def confirm
		@investment = current_user.investments.find(params[:id])
		@project = Project.find(@investment.project_id)
		@project.calculate_raised

		@investment.update_attribute(:stripe_card_ref, params[:cc_fingerprint])
		@investment.update_attribute(:confirmed, true)
	end
	
  protected

  def investment_params
		params.require(:investment).permit(:amount, :project_id)
  end
end