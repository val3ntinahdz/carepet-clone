class Appointment < ApplicationRecord
  belongs_to :pet
  belongs_to :service

  validates :reason, presence: true
  # validates :datetime, presence: true # dynamic datetime validation
  validate :datetime_cannot_be_in_the_past
  validate :datetime_must_be_available


  def datetime_cannot_be_in_the_past
    errors.add(:datetime, "can't be in the past") if datetime < DateTime.now
  end

  def datetime_must_be_available
    # if Appointment.exists?(datetime: datetime, service_id: service_id)
    #   errors.add(:datetime, 'is not available')
    # end
    appointment_duration = 1.hour
    appointment_start_time = datetime
    appointment_end_time = datetime + appointment_duration
    overlapping_appointments = Appointment.where(service_id: service_id)
                                          .where('datetime < ? AND ? < datetime + interval ?', appointment_end_time, appointment_start_time, '1 hour')
    if overlapping_appointments.exists?
      errors.add(:datetime, 'is not available')
    end
  end
end
