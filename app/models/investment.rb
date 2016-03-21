class Investment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  after_initialize :init
  before_validation :cast_amount

  validates :amount, numericality: { only_integer:true }

  def init
  	self.confirmed = false
  	self.charged = false
  end

  def charge!
  	Rails.logger.debug("-------CHARGE!-------")
  	Stripe.api_key = Rails.application.secrets.stripe_secret_key
  	user = User.find(self.user_id)
  	stripe_customer_ref = user.stripe_customer_ref
  	customer = Stripe::Customer.retrieve(stripe_customer_ref)

  	#TODO refactor ?
  	source = nil
  	customer.sources.each do |s|
  		if s[:fingerprint] == self.stripe_card_ref
  			source = s 
  			break
  		end
  	end
  	
  	Rails.logger.debug("Charge #{source} for #{self.amount}!")
  	Rails.logger.debug("brand: #{source.brand}")
  	Rails.logger.debug("last4: #{source.last4}")
  	Rails.logger.debug("---------------------")
  end

  private

  def cast_amount
  	self.amount = amount.to_i
  end
end
