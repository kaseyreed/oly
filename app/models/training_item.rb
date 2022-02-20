class TrainingItem < ApplicationRecord
  belongs_to :training

  has_many :training_items_movements
  has_many :training_items_results

  has_one :raw_training_item

  has_many :movements, through: :training_items_movements
end
