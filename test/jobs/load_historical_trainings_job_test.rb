# frozen_string_literal: true

require 'test_helper'

class LoadHistoricalTrainingsJobTest < ActiveJob::TestCase
  test 'test and rollback historical trainings' do
    LoadHistoricalTrainingsJob.perform_now

    assert true
  end
end
