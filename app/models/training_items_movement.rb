class TrainingItemsMovement < ApplicationRecord
  belongs_to :movement
  belongs_to :training_item
end
