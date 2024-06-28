class Condition < ApplicationRecord
  belongs_to :pet
  belongs_to :disease
end
