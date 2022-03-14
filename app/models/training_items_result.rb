class TrainingItemsResult < ApplicationRecord
  belongs_to :training_item

  default_scope { order(:index) }

  enum set_type: {
    ramp_up_set: 0,
    working_set: 1,
    backoff_set: 2,
    drop_set: 3,
  }
end
