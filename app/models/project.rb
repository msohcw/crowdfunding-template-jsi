class Project < ActiveRecord::Base
  belongs_to :user
  has_many :transactions
  has_many :backers, through: :transactions, source: :user
  after_initialize :init

  def init
  	self.raised ||= 0
  end

  def calculate_raised
    logger.info("---debug---")
    logger.debug(self.transactions.sum(:amount))
  	self.update_attribute(:raised, self.transactions.sum(:amount))
  	return self.raised
  end
end
