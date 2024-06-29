class CreateTrainings < ActiveRecord::Migration[7.1]
  def change
    create_table :trainings do |t|
      t.date :date
      t.string :title
      t.text :description
      t.integer :duration
      t.integer :calories_burned
      t.boolean :completed
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
