include ActionView::Helpers::DateHelper

class Project < ActiveRecord::Base
  belongs_to :user
  has_many :investments
  has_many :backers, through: :investments, source: :user
  after_initialize :init

  def init
  	self.raised ||= 0
  end

  def calculate_raised
    self.update_attribute(:raised, self.investments.sum(:confirmed_amount))
  	return self.raised
  end

  def expired?
    return Time.now > self.expires
  end

  def readable_time_left
    approximate = distance_of_time_in_words(Time.now, self.expires, include_seconds:true)
    approximate = approximate.gsub('less than a ', '1').gsub('half a minute ', '30 seconds').gsub(/((less than)|(about)) /, '')
    return approximate
  end
end