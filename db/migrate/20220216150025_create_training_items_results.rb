class CreateTrainingItemsResults < ActiveRecord::Migration[7.0]
  def change
    create_table :training_items_results do |t|
      t.references :training_item, null: false, foreign_key: true
      t.integer :index
      t.integer :reps
      t.integer :weight
      t.text :unit
      t.boolean :miss
      t.integer :set_type

      t.timestamps
    end
  end
end
