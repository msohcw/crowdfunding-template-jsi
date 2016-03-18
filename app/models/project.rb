class Project < ActiveRecord::Base
  belongs_to :user

  after_initialize :init

  def init
  	self.raised ||= 0
  	self.backers ||= 0
  end
end
