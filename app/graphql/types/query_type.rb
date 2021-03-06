# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :movement, Types::MovementType, null: true do
      argument :id, ID, required: true
    end

    field :movements, Types::MovementType.connection_type, null: false do
      argument :search_term, String, required: false
    end
    field :trainings, Types::TrainingType.connection_type, null: false do
      argument :states, [TrainingStateEnum], required: false
    end
    field :training, Types::TrainingType, null: true do
      argument :id, ID, required: true
    end

    field :training_item, Types::TrainingItemType, null: true do
      argument :id, ID, required: true
    end

    def movement(id:)
      Movement.find(id)
    end

    def movements(search_term: nil)
      if search_term
        Movement.where('name ILIKE ?', "%#{search_term}%").order(:name)
      else
        Movement.all.order(:name)
      end
    end

    def trainings(states: nil)
      if states
        Training.where(state: states).order(date: :desc)
      else
        Training.order(date: :desc)
      end
    end

    def training(id:)
      Training.find(id)
    end

    def training_item(id:)
      TrainingItem.find(id)
    end
  end
end
