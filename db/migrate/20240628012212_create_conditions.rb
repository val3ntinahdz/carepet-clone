class CreateConditions < ActiveRecord::Migration[7.1]
  def change
    create_table :conditions do |t|
      t.date :diagnosis_date
      t.date :recovery_date
      t.string :comments
      t.references :pet, null: false, foreign_key: true
      t.references :disease, null: false, foreign_key: true

      t.timestamps
    end
  end
end
