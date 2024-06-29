class RemoveColumnsFromPets < ActiveRecord::Migration[7.1]
  def change
    remove_column :pets, :vaccines, :string
    remove_column :pets, :allergies, :string
  end
end
