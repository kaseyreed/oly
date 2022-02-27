class UpdateTrainingItemRepScheme < ActiveRecord::Migration[7.0]
  def change
    remove_column :training_items, :rep_scheme, :text
    add_column :training_items, :rep_scheme, :integer, array: true
  end
end
