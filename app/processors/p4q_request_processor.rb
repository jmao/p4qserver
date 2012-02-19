class P4qRequestProcessor

  # Check whether the target branch is locked, if not, unshelve and submit
  def process(change_id, branches)
    Rails.logger.info "Processing change: #{change_id}"
    check_output = `bin/p4lockcheck.sh trunk`
    check_result_trunk = $?.to_i
    check_output = check_output + `bin/p4lockcheck.sh release`
    check_result_release = $?.to_i

    if branches == 1
      check_result = check_result_trunk
    elsif branches == 2
      check_result = check_result_release
    else
      check_result = check_result_trunk | check_result_release
    end

    Rails.logger.info "Branches locking check: #{check_result}"
    Rails.logger.info check_output

    if check_result == 0
      submit_output = `ruby bin/p4dq.rb "#{change_id}"`
      submit_result = $?.to_i
      Rails.logger.info "Submit result: #{submit_result}"
      Rails.logger.info submit_output
      if submit_result == 0
        changelist = Changelist.where(:p4number => change_id).first
        changelist.update_attributes(:status => 'processed')
      end
    end
  end
end
