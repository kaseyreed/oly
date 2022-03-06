class RawTraining < ApplicationRecord
  has_many :raw_training_items, dependent: :destroy

  def items
    raw_training_items
  end

  class << self
    def process_raw_trainings(raw_trainings)
      raw_trainings.each do |rt|
        RawTraining.transaction do
          training = Training.create!(
            raw_training_id: rt.id,
            title: rt.name,
            date: DateTime.parse(rt.date),
            state: Training.states[rt[:state]],
            warmup: rt.warmup,
            cooldown: rt.cooldown
          )

          rt.raw_training_items.each do |rti|
            RawTrainingItem.process_raw_training_item(rti, training_id: training.id)
            rti.processed = true
            rti.save!
          end

          rt.processed = true
          rt.save!
        end
      end
    end
  end
end
