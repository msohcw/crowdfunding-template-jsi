class Project < ActiveRecord::Base
  belongs_to :user
  has_many :investments
  has_many :backers, through: :investments, source: :user
  after_initialize :init

  def init
  	self.raised ||= 0
  end

  def calculate_raised
    logger.debug("---investments---")
    logger.debug(self.investments.where(confirmed: true))
    logger.debug("---amount---")
    logger.debug(self.investments.where(confirmed: true).sum(:amount))
    self.update_attribute(:raised, self.investments.where(:confirmed => true).sum(:amount))
  	return self.raised
  end

  def expired?
    return Time.now > self.expires
  end
end