class Appointment < ApplicationRecord
  belongs_to :pet
  belongs_to :service

  validates :reason, :datetime, presence: true

  def end_time
    datetime + 1.hour
  end

  def time
    "#{datetime.strftime('%I:%M %p')} - #{end_time.strftime('%I:%M %p')}"
  end

  def multi_days?
    (end_time.to_date - datetime.to_date).to_i >= 1
  end
end
