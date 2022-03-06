# frozen_string_literal: true
class TrainingItem < ApplicationRecord
  belongs_to :training
  belongs_to :raw_training_item, foreign_key: :raw_training_items_id

  has_many :training_items_movements
  has_many :training_items_results

  has_many :movements, through: :training_items_movements

  enum state: {
    pending: 0,
    completed: 1,
    missed: 2,
    skipped: 3
  }

  def results
    training_items_results
  end
end
