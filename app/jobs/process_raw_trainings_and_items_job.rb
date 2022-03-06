class ProcessRawTrainingsAndItemsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # load raw training date
    raw_trainings = RawTraining.where(processed: false)
    raw_training_items = raw_trainings.map(&:raw_training_items).flatten

    # process raw training item names into movements
    movements = raw_training_items.map(&:name)
    Movement.process_raw_movements(movements)

    # process raw trainings and items into core models
    RawTraining.process_raw_trainings(raw_trainings)
  end
end
