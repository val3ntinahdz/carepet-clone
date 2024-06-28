class CreateVaccinations < ActiveRecord::Migration[7.1]
  def change
    create_table :vaccinations do |t|
      t.date :date
      t.string :comments
      t.references :pet, null: false, foreign_key: true
      t.references :vaccine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
