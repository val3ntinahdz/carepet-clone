class Allergy < ApplicationRecord
  belongs_to :pet
  belongs_to :allergen
end
