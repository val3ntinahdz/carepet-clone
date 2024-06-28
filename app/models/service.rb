class Service < ApplicationRecord
  belongs_to :veterinary
  has_many :appointments
end
