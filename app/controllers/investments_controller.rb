class InvestmentsController < ApplicationController
	before_action -> { project_exists?(params[:project_id]) }, only: [:new, :create]
	before_action :has_invested?,					only: [:new, :create]
	before_action :is_investment_owner?, 	only: [:edit, :update, :confirm]
	before_action :project_expired?

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
			render 'create'
		end
	end

	def edit
		@investment = current_user.investments.find(params[:id])
		@project = @investment.project_id
	end

	def update
		@investment = current_user.investments.find(params[:id])
		@project = Project.find(@investment.project_id)

		if @investment.update_attribute(:amount, investment_params[:amount])
			redirect_to "/pledge/#{params[:id]}"
		end
	end

	def confirm
		@investment = current_user.investments.find(params[:id])
		@project = Project.find(@investment.project_id)
		
		@investment.update_attribute(:stripe_card_ref, params[:cc_fingerprint])
		@investment.update_attribute(:confirmed, true)
		
		@project.calculate_raised
	end
	
  protected

  def investment_params
		params.require(:investment).permit(:amount, :project_id)
  end

  def project_exists?(project_id)
  	@project = Project.find_by(id: project_id)
  	unless @project.present?
			flash[:error] = "We can't find the requested project."
  		redirect_to root_url
  	end
  end

  def is_investment_owner?
		@investment = current_user.investments.find_by(id: params[:id])
  	if @investment.present?
  		project_exists?(@investment.project_id)
  	else
			flash[:error] = "We can't find the requested investment."
			redirect_to root_url
		end
  end
	
	def project_expired?
		if @project.expired?
			flash[:error] = "This project has expired."
			redirect_to root_url
		end
  end

  def has_invested?
		@investment = current_user.investments.find_by(project_id: @project.id)
  	if @investment.present?
			flash[:warning] = "You have already backed this project."
			redirect_to edit_investment_path(investment.id)
  	end
  end
end