module Types
  class MovementType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :type, String, null: false
    field :complex, Boolean, null: false
    field :history, [MovementHistoryDatumType], null: false

    def history
      TrainingItem.joins(:training_items_movements, :training_items_results, :training)
                  .where(
                    training_items_movements: { movement_id: 8 },
                    training_items_results: { unit: 'kg', miss: false },
                    training_items: { rep_scheme: [1] }
                  )
                  .where('trainings.date > ?',  DateTime.new(2021, 01, 01))
                  .select('trainings.date as date, rep_scheme[1] as rep_scheme, max(weight) as weight, training_items_results.id as training_items_result_id, training_items.id as training_items_id, trainings.id as trainings_id')
                  .group('trainings.date, rep_scheme, training_items_results.id, training_items.id, trainings.id')
    end
  end
end