class Project < ActiveRecord::Base
  belongs_to :user
  has_many :investments
  has_many :backers, through: :investments, source: :user
  after_initialize :init

  def init
  	self.raised ||= 0
  end

  def calculate_raised
    self.update_attribute(:raised, self.investments.sum(:amount))
  	return self.raised
  end
end
