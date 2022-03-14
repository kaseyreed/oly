# frozen_string_literal: true

module Types
  class TrainingStateEnum < Types::BaseEnum
    value 'PENDING', value: :pending
    value 'COMPLETED', value: :completed
    value 'MISSED', value: :missed
    value 'SKIPPED', value: :skipped
  end
end
