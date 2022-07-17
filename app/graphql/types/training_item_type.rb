module Types
  class TrainingItemType < Types::BaseObject
    field :id, ID, null: false
    field :index, Int, null: false
    field :complex, Boolean, null: false
    field :num_sets, Int, null: false
    field :rep_scheme, [Int], null: false
    field :state, TrainingStateEnum, null: false
    field :superset, Boolean, null: true
    field :movements, [MovementType], null: false

    # consider making this a sub object? or maybe a top-level field?
    field :original_name, String, null: false
    field :original_description, String, null: false

    field :results, TrainingItemResultsType, null: true
    field :training, TrainingType, null: false


    def state
      object.state.to_sym
    end

    def original_name
      object.raw_training_item[:name]
    end

    def original_description
      object.raw_training_item[:description]
    end

    def rep_scheme
      if object.rep_scheme.present?
        object.rep_scheme
      else
        []
      end
    end

    def training
      object.training
    end

    def results
      object.training_items_results
    end
  end
end