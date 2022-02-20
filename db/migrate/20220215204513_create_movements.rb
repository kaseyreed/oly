class CreateMovements < ActiveRecord::Migration[7.0]
  def change
    create_table :movements do |t|
      t.text :name
      t.text :movement_type
      t.boolean :complex

      t.timestamps
    end
  end
end
