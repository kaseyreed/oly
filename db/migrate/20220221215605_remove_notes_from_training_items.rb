class RemoveNotesFromTrainingItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :training_items, :notes, :text
  end
end
