# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject

    field :movements, Types::MovementType.connection_type, null: false
    field :trainings, Types::TrainingType.connection_type, null: false

    def movements
      Movement.all
    end

    def trainings
      Training.all.order(date: :desc)
    end
  end
end
