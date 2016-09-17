# Crowdfunding Website Template

This is a Ruby on Rails template for a crowdfunding website.

*NOTE: This repository is marked jsi or just-ship-it which means i) I am not actively supporting it, ii) It's at least partially unfinished in some way, iii) I do not see myself continuining it in the short term iv) bugs abound. Tread with caution.*

This project was built to run on
* Amazon Elastic Beanstalk with EC2 autoscaling groups,
* Amazon RDS database (postgresql)
* Amazon ElastiCache (Redis) to back resque (Ruby library for queues, works with ActiveJob) and resque-scheduler, resque-web
* Mailgun for emails (processed on resque)
* Stripe for processing payments
* Authy for 2-factor authentication (Unfinished)
* LinkedIn login, with the option to add more accounts via omniauth
* CSS styles are all derived from skeleton.css. Keys are all pulled from environment.

Brief setup instructions
* Setup Postgres with user and password, as in config/database.yml
* Setup Redis
* Setup secrets.yml with the necessary keys
* `rake db:reset db:migrate`
* Run resque `rake environment resque:work QUEUE=*`
* resque-scheduler `rake environment resque:scheduler`
* rails s
