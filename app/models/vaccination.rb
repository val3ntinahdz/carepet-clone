class Vaccination < ApplicationRecord
  belongs_to :pet
  belongs_to :vaccine

  validates :date, presence: true
  validates :vaccine, presence: true
end
