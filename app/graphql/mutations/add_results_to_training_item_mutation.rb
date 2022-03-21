# frozen_string_literal: true
#

module Mutations
  class AddResultsToTrainingItemMutation < Mutations::BaseMutation
    class AddResultsToTrainingItemSetInput < Types::BaseInputObject
      argument :reps, Integer, required: true
      argument :weight, Integer, required: true
      argument :unit, String, required: true
      argument :miss, Boolean, required: false
    end

    class AddResultsToTrainingItemInput < ::Types::BaseInputObject
      argument :training_item_id, ID, required: true
      argument :warmup_sets, [AddResultsToTrainingItemSetInput], required: false
      argument :working_sets, [AddResultsToTrainingItemSetInput], required: false
      argument :cooldown_sets, [AddResultsToTrainingItemSetInput], required: false
    end

    argument :input, AddResultsToTrainingItemInput, required: true

    field :training_item, Types::TrainingItemType, null: true
    field :errors, [String], null: true

    def resolve(input:)
      training_item = TrainingItem.find(input.training_item_id)

      training_item.training_items_results.destroy_all

      input.warmup_sets.each do |set|
        training_item.training_items_results.create(
          reps: set.reps,
          weight: set.weight,
          unit: set.unit,
          miss: set.miss,
          set_type: :ramp_up_set
        )
      end if input.warmup_sets.present?

      input.working_sets.each do |set|
        training_item.training_items_results.create(
          reps: set.reps,
          weight: set.weight,
          unit: set.unit,
          miss: set.miss,
          set_type: :working_set
        )
      end if input.working_sets.present?

      input.cooldown_sets.each do |set|
        training_item.training_items_results.create(
          reps: set.reps,
          weight: set.weight,
          unit: set.unit,
          miss: set.miss,
          set_type: :cooldown_set
        )
      end if input.cooldown_sets.present?

      {
        training_item: training_item,
        errors: []
      }
    end
  end
end