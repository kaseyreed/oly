# frozen_string_literal: true

module Types
  class MovementHistoryDatumType < Types::BaseObject
    field :num_reps, Int, null: false
    field :date, GraphQL::Types::ISO8601Date, null: false
    field :weight, Float, null: false
    field :training_id, ID, null: false
    field :training_item_id, ID, null: false
    field :training_item_result_id, ID, null: false
  end
end