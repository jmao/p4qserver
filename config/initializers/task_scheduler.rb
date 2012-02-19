require 'rubygems'
require 'rufus/scheduler'
require File.dirname(__FILE__) + '/../../app/processors/p4q_request_processor'

## to start scheduler
scheduler = Rufus::Scheduler.start_new

## It will print message every i minute
scheduler.every '10s', :first_in => '2s', :blocking => true do
  changelist = Changelist.where("status = 'new'").first(:order => 'p4number')

  if changelist
    processor = P4qRequestProcessor.new
    processor.process(changelist.p4number, changelist.branches)
  end
end