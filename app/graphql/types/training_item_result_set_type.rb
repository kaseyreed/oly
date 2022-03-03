# frozen_string_literal: true

module Types
  class TrainingItemResultSetType < Types::BaseObject
    # field :num_sets, Int, null: false
    field :reps, Int, null: false
    field :weight, Float, null: false
    field :weight_lbs, Float, null: false
    field :miss, Boolean, null: false
  end
end
