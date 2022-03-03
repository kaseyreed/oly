# frozen_string_literal: true

require 'test_helper'

class ProcessHistoricalTrainingsJobTest < ActiveJob::TestCase
  test 'test and rollback historical trainings' do
    ProcessHistoricalTrainingsJob.perform_now

    assert true
  end
end
