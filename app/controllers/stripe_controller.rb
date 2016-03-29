require 'stripe'

class StripeController < ApplicationController
	before_action :load_stripe_key

	def add_payment_method
		if request.xhr?
		
			if current_user.stripe_customer_ref.present?
				customer = Stripe::Customer.retrieve(current_user.stripe_customer_ref)
				customer.sources.create(:source => stripe_token)
				logger.debug("--debug--")
				logger.debug(customer)
				logger.debug(customer.id)
			else
				customer = Stripe::Customer.create(:email => current_user.email, :source => stripe_token)
				current_user.update_attribute(:stripe_customer_ref, customer.id)
			end

			@reply = {status: 200, data: "Payment method added"}
			respond_to do |format|
				format.json {	render :json => @reply }
			end
		else
			# 403 forbidden
			redirect_to root_url
		end
	end

	def pledge
		@investment = current_user.investments.find_by(id: params[:id]) 
		if @investment.present?
			logger.debug("investment")
			logger.debug(@investment.intended_amount)
			@project = Project.find(@investment.project_id)
			if current_user.stripe_customer_ref.present?
				customer = Stripe::Customer.retrieve(current_user.stripe_customer_ref)
				sources = customer.sources

				@filtered_cards = []

				sources.each do |source|
					if source[:cvc_check] == 'pass'
						card = {
							:fingerprint => source[:fingerprint],
							:brand => source[:brand],
							:last4 => source[:last4],
							:exp_month => source[:exp_month],
							:exp_year => source[:exp_year]
						}
						@filtered_cards.push(card)
					end
				end
			end
		else # investment does not belong to current user
			# 403 forbidden
			redirect_to root_url
		end
	end

	protected

	def load_stripe_key
		Stripe.api_key = Rails.application.secrets.stripe_secret_key
	end

	def stripe_token
		params.permit('stripe_token')[:stripe_token]
	end 
end
