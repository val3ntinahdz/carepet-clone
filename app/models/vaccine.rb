class Vaccine < ApplicationRecord
  has_many :vaccinations, dependent: :destroy
end
