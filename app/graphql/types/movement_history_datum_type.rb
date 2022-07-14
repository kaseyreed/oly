# frozen_string_literal: true

module Types
  class MovementHistoryDatumType < Types::BaseObject
    field :id, ID, null: false
    field :training_item, Types::TrainingItemType, null: false
    field :date, GraphQL::Types::ISO8601Date, null: false
    field :weight, Float, null: false
  end
end