module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    # field :complete_training, mutation: Mutations::CompleteTraining
    # field :complete_training_item, mutation: Mutations::CompleteTrainingItem
    # field :record_results, mutation: Mutations::AddTrainingResult
  end
end
