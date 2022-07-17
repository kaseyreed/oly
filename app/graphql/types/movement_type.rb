module Types
  class MovementType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :type, String, null: false
    field :complex, Boolean, null: false
    field :history, [MovementHistoryDatumType], null: false do
      argument :variance, Float, required: false
    end

    def history(variance: nil)
      movement_id = object.id
      history_by_rep_scheme = HistoryService.get_movement_history(
        movement_id: movement_id,
        variance: variance
      )

      history_by_rep_scheme.values.flatten.sort_by { |h| h[:date] }
    end
  end
end