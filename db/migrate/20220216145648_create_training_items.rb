class CreateTrainingItems < ActiveRecord::Migration[7.0]
  def change
    create_table :training_items do |t|
      t.references :training, null: false, foreign_key: true
      t.integer :index
      t.boolean :complex
      t.integer :num_sets
      t.integer :rep_scheme, array: true, default: []
      t.integer :state
      t.text :notes
      t.boolean :superset
      t.references :raw_training_items, null: false, foreign_key: true

      t.timestamps
    end
  end
end
