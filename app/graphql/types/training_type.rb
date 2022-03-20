module Types
  class TrainingType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :date, GraphQL::Types::ISO8601DateTime, null: false

    field :state, TrainingStateEnum, null: false
    field :warmup, String
    field :cooldown, String

    field :items, [TrainingItemType], null: false

    def state
      object.state.to_sym
    end
  end
end