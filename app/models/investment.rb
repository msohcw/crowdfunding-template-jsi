class Investment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  # before_create :init
  before_validation :cast_amount

  validates :intended_amount, numericality: { only_integer:true }
  validates :confirmed_amount, numericality: { only_integer:true }

  def charge!
  	# Rails.logger.debug("-------CHARGE!-------")
  	Stripe.api_key = Rails.application.secrets.stripe_secret_key
  	user = User.find(self.user_id)
  	project = Project.find(self.project_id)
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
  	
  	Stripe::Charge.create(
  		:amount => self.confirmed_amount * 100, # TODO x100 is for temp conversion to cents 
  		:currency => 'sgd',
  		:description => "Backing for #{project.name} (#{self.project_id})",
  		:customer => customer.id,
  		:source => source.id
  		)

  	# Rails.logger.debug("Charge #{source} for #{self.amount}!")
  	# Rails.logger.debug("brand: #{source.brand}")
  	# Rails.logger.debug("last4: #{source.last4}")
  	# Rails.logger.debug("---------------------")
  end

  private

  def init
    self.intended_amount = 0
    self.confirmed_amount = 0
  end

  def cast_amount
    self.intended_amount = self.intended_amount.to_i
  	self.confirmed_amount = self.confirmed_amount.to_i
  end
end
