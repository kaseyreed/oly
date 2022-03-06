# frozen_string_literal: true

class AddStateToRawModels < ActiveRecord::Migration[7.0]
  def change
    add_column :raw_trainings, :state, :string, default: 'pending'
    add_column :raw_training_items, :state, :string, default: 'pending'
  end
end
