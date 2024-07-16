class Condition < ApplicationRecord
  belongs_to :pet
  belongs_to :disease

  broadcasts_to ->(condition) { 'conditions' }, inserts_by: :prepend
end
