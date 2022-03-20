# frozen_string_literal: true

module Types
  class TrainingItemResultsType < Types::BaseObject
    field :notes, String, null: false

    field :warmup_sets, [Types::TrainingItemResultSetType], null: false
    field :working_sets, [Types::TrainingItemResultSetType], null: false
    field :backoff_sets, [Types::TrainingItemResultSetType], null: false

    def working_sets
      object.where(set_type: :working_set)
    end
  end


end
