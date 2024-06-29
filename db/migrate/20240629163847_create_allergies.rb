class CreateAllergies < ActiveRecord::Migration[7.1]
  def change
    create_table :allergies do |t|
      t.date :detected_on
      t.string :severity
      t.text :reactions
      t.text :comments
      t.references :pet, null: false, foreign_key: true
      t.references :allergen, null: false, foreign_key: true

      t.timestamps
    end
  end
end
