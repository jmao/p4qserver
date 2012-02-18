require 'rubygems'
require 'rufus/scheduler'

## to start scheduler
scheduler = Rufus::Scheduler.start_new

## It will print message every i minute
scheduler.every("10s") do
  Rails.logger.info "HELLO #{Time.now}"

  # p4 change -o 151301 > change.out
  # grep -n "~Description:" change.out
  #   26:Description:
  # wc -l change.out
  #  28 change.out
  # tail -n (28-26) change.out > description.out
end