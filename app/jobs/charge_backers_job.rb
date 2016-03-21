class ChargeBackersJob < ActiveJob::Base
  queue_as :default

  def perform(project)
  	project.calculate_raised
  	if project.expired? and project.raised > project.target # verify project expiry
  		investments = Investment.where(project_id:project.id, confirmed:true)
  		investments.each do |investment|
  			investment.charge!
  		end
  	end
  end
end