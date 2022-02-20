class CreateRawTrainings < ActiveRecord::Migration[7.0]
  def change
    create_table :raw_trainings do |t|
      t.text :date
      t.text :name
      t.text :warmup
      t.text :cooldown
      t.boolean :processed

      t.timestamps
    end

    add_reference :trainings, :raw_training, foreign_key: true
  end
end
