module Types
  class MutationType < Types::BaseObject
    # field :complete_training, mutation: Mutations::CompleteTraining
    # field :complete_training_item, mutation: Mutations::CompleteTrainingItem
    # field :record_results, mutation: Mutations::AddTrainingResult

    field :test_field, mutation: Mutations::TestMutation
    field :update_training, mutation: Mutations::UpdateTrainingMutation
    field :add_results_to_training_item, mutation: Mutations::AddResultsToTrainingItemMutation
  end
end
