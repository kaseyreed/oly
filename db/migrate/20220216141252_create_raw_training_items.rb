class CreateRawTrainingItems < ActiveRecord::Migration[7.0]
  def change
    create_table :raw_training_items do |t|
      t.references :raw_training, null: false, foreign_key: true
      t.text :name
      t.text :description
      t.boolean :superset
      t.boolean :processed
      t.integer :index
      t.text :results

      t.timestamps
    end
  end
end
