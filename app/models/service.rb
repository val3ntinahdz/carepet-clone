class Service < ApplicationRecord
  belongs_to :veterinary
  has_many :appointments

  include PgSearch::Model
  pg_search_scope :search_by,
  against: [ :name, :category, :description ],
  using: {
    tsearch: { prefix: true }
  }
end
