require "rubygems"
require "rufus/scheduler"

## to start scheduler
scheduler = Rufus::Scheduler.start_new

## It will print message every i minute
scheduler.every("1m") do
	puts User.last
#AplicationMailer.enviarcorreo("javier_suazo@live.com").deliver
end

## Prints the message every day at noon
scheduler.cron("0,2 * * * *") do
 # puts("HI #{Time.now}")
end

scheduler.in '20m' do

end

