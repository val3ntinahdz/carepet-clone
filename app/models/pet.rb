class Pet < ApplicationRecord
  belongs_to :user
  has_many :vaccinations
  has_many :vaccines, through: :vaccinations
  has_many :conditions
  has_many :diseases, through: :conditions
  has_many :appointments
  has_many :services, through: :appointments
  has_many :veterinaries, through: :services
  has_many :trainings
  has_many :nutritions
  has_many :allergies
  has_many :allergens, through: :allergies
end
