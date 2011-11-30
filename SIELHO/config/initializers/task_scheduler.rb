require "rubygems"
require "rufus/scheduler"

## to start scheduler
scheduler = Rufus::Scheduler.start_new

## It will print message every i minute
scheduler.every("1m") do
 @a = User.all
 puts @a.size
end

## Prints the message every day at noon
scheduler.cron("0,2 * * * *") do
  puts("HI #{Time.now}")
end

scheduler.in '20m' do
  puts "order butter"
end

scheduler.at 'Thu Mar 26 07:31:43 +0900 2009' do
  puts 'order pizza'
end

scheduler.cron '0 22 * * 1-5' do
  # every day of the week at 22:00 (10pm)
  puts 'activate security system'
end

scheduler.every '5m' do
  puts 'check status report'
end
