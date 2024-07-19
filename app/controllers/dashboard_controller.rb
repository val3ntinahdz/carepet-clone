class DashboardController < ApplicationController
  def dashboard
    if current_user.veterinary.present?
      @appointments = current_user.appointments.order(:datetime).where.not(status: 'completed').limit(5)
    else
      @pets = current_user.pets
    end
  end
end
