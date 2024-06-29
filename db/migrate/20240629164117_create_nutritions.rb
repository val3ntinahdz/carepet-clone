class CreateNutritions < ActiveRecord::Migration[7.1]
  def change
    create_table :nutritions do |t|
      t.date :date
      t.string :meal_type
      t.string :food_items
      t.integer :calories
      t.text :notes
      t.boolean :completed
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
