class CreatePets < ActiveRecord::Migration[7.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :pet_type
      t.string :breed
      t.date :birthday_date
      t.string :gender
      t.integer :weight
      t.integer :height
      t.string :vaccines
      t.string :allergies
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
