class TrainingItemsMovement < ApplicationRecord
  belongs_to :movement
  belongs_to :training_item

  default_scope { order(:rep_scheme_idx) }
end
