# frozen_string_literal: true

module Types
  class TrainingItemResultsType < Types::BaseObject
    field :notes, String, null: false

    field :ramp_up_sets, [Types::TrainingItemResultSetType], null: false
    field :working_sets, [Types::TrainingItemResultSetType], null: false
    field :cooldown_sets, [Types::TrainingItemResultSetType], null: false

    def working_sets
      object.where(set_type: :working_set)
    end

    def ramp_up_sets
      object.where(set_type: :ramp_up_set)
    end

    def cooldown_sets
      object.where(set_type: :cooldown_set)
    end
  end


end
