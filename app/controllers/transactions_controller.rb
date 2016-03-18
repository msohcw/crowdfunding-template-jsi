class TransactionsController < ApplicationController
	def new
		@transaction = Transaction.new
		@project = params[:project_id]
	end
	
	def create
		@transaction = current_user.transactions.build(transaction_params)
  	if @transaction.save
  		flash[:success] = "Project backed for #{@transaction.amount}"
  		@transaction.project.calculate_raised
  	else
  		flash[:failure] = "Error in backing project."
  	end
  	redirect_to root_url
	end
	
  protected

  def transaction_params
		params.require(:transaction).permit(:amount, :project_id)
  end
end
