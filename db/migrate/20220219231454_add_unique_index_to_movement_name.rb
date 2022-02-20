class AddUniqueIndexToMovementName < ActiveRecord::Migration[7.0]
  def change
    add_index :movements, :name, unique: true
  end
end
