# frozen_string_literal: true

module Mutations
  class UpdateTrainingMutation < Mutations::BaseMutation
    class UpdateTrainingInput < ::Types::BaseInputObject
      argument :id, ID, required: true
      argument :state, ::Types::TrainingStateEnum, required: true
    end

    argument :input, UpdateTrainingInput, required: true

    field :training, ::Types::TrainingType, null: false
    field :errors, [String], null: true

    def resolve(input:)
      training = Training.find(input.id)

      training.update!(input.to_h)
      {
        training:,
        errors: []
      }
    end
  end
end
