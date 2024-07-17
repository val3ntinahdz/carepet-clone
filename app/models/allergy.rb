class Allergy < ApplicationRecord
  belongs_to :pet
  belongs_to :allergen

  broadcasts_to ->(allergy) { 'allergies' }, inserts_by: :prepend
end
