class Project < ActiveRecord::Base
  belongs_to :user
  has_many :transactions
  has_many :backers, through: :transactions, source: :users 
  after_initialize :init

  def init
  	self.raised ||= 0
  	self.backers ||= 0
  end

  protected

  def calculate_raised
  	self.raised = self.transactions.sum(:amount)
  	return self.raised
  end
end
