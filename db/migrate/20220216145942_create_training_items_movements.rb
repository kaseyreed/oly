class CreateTrainingItemsMovements < ActiveRecord::Migration[7.0]
  def change
    create_table :training_items_movements do |t|
      t.references :training_item, null: false, foreign_key: true
      t.references :movement, null: false, foreign_key: true
      t.integer :rep_scheme_idx

      t.timestamps
    end
  end
end
