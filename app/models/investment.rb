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

  private

  def cast_amount
  	self.amount = amount.to_i
  end
end
