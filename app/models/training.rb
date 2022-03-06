class Training < ApplicationRecord
  has_many :raw_training_items, dependent: :destroy
  has_many :training_items, dependent: :destroy

  enum state: {
    pending: 0,
    completed: 1,
    missed: 2,
    skipped: 3
  }

  def items
    training_items
  end
end
