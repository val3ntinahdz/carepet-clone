class Appointment < ApplicationRecord
  belongs_to :pet
  belongs_to :service

  validates :reason, :datetime, presence: true
end
