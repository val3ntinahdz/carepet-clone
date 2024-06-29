class AddColorToPets < ActiveRecord::Migration[7.1]
  def change
    add_column :pets, :color, :string
  end
end
