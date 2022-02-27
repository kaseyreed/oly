module Types
  class TrainingType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :date, String, null: false

    field :state, TrainingState, null: false
    field :warmup, String
    field :cooldown, String

    field :items, [TrainingItem], null: false

    def state
      :ready
    end
  end
end