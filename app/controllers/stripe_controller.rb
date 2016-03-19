require 'stripe'

class StripeController < ApplicationController
	
	def add_payment_method
		if request.xhr?
			Stripe.api_key = Rails.application.secrets.stripe_secret_key
		
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
			redirect_to root_url
		end
	end

	protected

	def stripe_token
		params.permit('stripe_token')[:stripe_token]
	end 
end
