class CreateAllergens < ActiveRecord::Migration[7.1]
  def change
    create_table :allergens do |t|
      t.string :name

      t.timestamps
    end
  end
end
