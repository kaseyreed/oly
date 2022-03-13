module Types
  class MutationType < Types::BaseObject
    # field :complete_training, mutation: Mutations::CompleteTraining
    # field :complete_training_item, mutation: Mutations::CompleteTrainingItem
    # field :record_results, mutation: Mutations::AddTrainingResult

    field :test_field, mutation: Mutations::TestMutation
  end
end
