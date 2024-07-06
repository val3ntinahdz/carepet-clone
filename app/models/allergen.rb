class Allergen < ApplicationRecord
  has_many :allergies, dependent: :destroy
end
