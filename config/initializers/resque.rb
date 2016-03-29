if Rails.env.development?
  Resque.redis = Redis.new(:url => "redis://localhost:6379")
elsif Rails.env.production?
  Resque.redis = Redis.new(:url => "redis://kckstr-experiment.qnbfbc.0001.apse1.cache.amazonaws.com:6379" )
end

Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }
