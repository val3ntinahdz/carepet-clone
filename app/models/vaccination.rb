class Vaccination < ApplicationRecord
  belongs_to :pet
  belongs_to :vaccine

  validates :date, presence: true

  broadcasts_to ->(vaccination) { 'vaccinations' }, inserts_by: :prepend
end
