class ProcessRawTrainingsAndItemsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    raw_trainings = RawTraining.where(processed: false)
    raw_trainings.each do |raw_training|
      raw_training.process_raw_training
    end

  end
end
