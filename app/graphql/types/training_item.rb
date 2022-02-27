module Types
  class TrainingItem < Types::BaseObject
    field :id, ID, null: false
    field :index, Int, null: false
    field :complex, Boolean, null: false

    field :num_sets, Int, null: false
    field :rep_scheme, [Int], null: false
    field :state, TrainingState, null: false
    field :superset, Boolean, null: true

    field :movements, [MovementType], null: false

    def state
      :ready
    end

    def rep_scheme
      if object.rep_scheme.present?
        object.rep_scheme
      else
        []
      end
    end
  end
end