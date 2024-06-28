class CreateVeterinaries < ActiveRecord::Migration[7.1]
  def change
    create_table :veterinaries do |t|
      t.string :dni
      t.string :specialization
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
