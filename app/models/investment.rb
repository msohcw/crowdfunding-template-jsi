class Investment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  before_validation :cast_amount

  validates :amount, numericality: { only_integer:true }

  private

  def cast_amount
  	self.amount = amount.to_i
  end
end
