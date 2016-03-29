class InvestmentsController < ApplicationController
	before_action -> { project_exists?(params[:project_id]) }, only: [:new]	# passed in via URL parameters
	before_action -> { project_exists?(investment_params[:project_id]) }, only: [:create] # passed in via form parameters
	before_action :has_invested?,					only: [:new, :create]
	before_action :is_investment_owner?, 	only: [:edit, :update, :confirm, :cancel, :destroy]
	before_action :project_expired?

	def new
		@investment = Investment.new
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
	end

	def update
		if investment_params[:intended_amount].to_i == 0
			render 'cancel'
		elsif @investment.update(intended_amount: investment_params[:intended_amount])
			redirect_to "/pledge/#{params[:id]}"
		end
	end

	def cancel
	end

	def destroy
		current_user.investments.find(params[:id]).destroy
		@project.calculate_raised
		flash[:success] = "Your backing for #{@project.name} has been cancelled."
		redirect_to root_url
	end


	def confirm
		logger.debug("confirm")
		logger.debug(@investment.intended_amount)

		if @investment.update(stripe_card_ref: params[:cc_fingerprint], confirmed_amount: @investment.intended_amount)
			@project.calculate_raised
		else
			flash[:failure] = "Error in backing project."
			redirect_to root_url
		end
	end
	
  protected

  def investment_params
		params.require(:investment).permit(:intended_amount, :project_id)
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