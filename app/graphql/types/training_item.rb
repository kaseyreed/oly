module Types
  class TrainingItem < Types::BaseObject
    field :id, ID, null: false
    field :index, Int, null: false
    field :complex, Boolean, null: false

    field :num_sets, Int, null: false
    # field :rep_scheme, null: false
    field :state, TrainingState, null: false
    field :superset, Boolean, null: true

    field :movements, [MovementType], null: false

    def state
      :ready
    end
  end
end