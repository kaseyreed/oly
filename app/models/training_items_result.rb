class TrainingItemsResult < ApplicationRecord
  belongs_to :training_item

  default_scope { order(:index) }
end
