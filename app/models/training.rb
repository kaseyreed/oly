class Training < ApplicationRecord
  has_many :raw_training_items, dependent: :destroy
  has_many :training_items, dependent: :destroy
end
