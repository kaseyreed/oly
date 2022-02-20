class CreateTrainings < ActiveRecord::Migration[7.0]
  def change
    create_table :trainings do |t|
      t.text :title
      t.timestamp :date
      t.integer :state

      t.text :warmup
      t.text :cooldown

      t.timestamps
    end
  end
end
