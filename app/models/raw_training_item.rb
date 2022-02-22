class RawTrainingItem < ApplicationRecord
  belongs_to :raw_training


  class << self
    def process_raw_training_item(raw_training_item, training_id:)
      movements = Movement.find_by_raw(raw_training_item.name)

      complex = movements.length > 1
      num_sets = parse_sets(raw_training_item.description)
      rep_scheme = parse_rep_scheme(raw_training_item.description)

      TrainingItem.create!(
        training_id:,
        index: raw_training_item.index,
        complex:,
        num_sets:,
        rep_scheme:,
        state: 0,
        # notes: nil,
        superset: raw_training_item.superset,
        raw_training_items_id: raw_training_item.id,
        movements:
      )
    end

    def parse_sets(info)
      3
    end

    def parse_rep_scheme(info)
      [1]
    end
  end
end
