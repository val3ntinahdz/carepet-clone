class DashboardController < ApplicationController
  helper_method %i[trainings_for_today? meals_for_today? all_daily_meals_completed? all_daily_trainings_completed? weekly_appointments_upcoming?]

  def dashboard
    if current_user.veterinary.present?
      @appointments = current_user.appointments.order(:datetime).where.not(status: 'completed').limit(5)
    else
      @pets = current_user.pets
    end
  end

  def trainings_for_today?(pet)
    !pet.trainings.where(date: Date.today).empty?
  end

  def meals_for_today?(pet)
    pet.nutritions.where(date: Date.today).size == 3
  end

  def all_daily_trainings_completed?(pet)
    pet.trainings.where(date: Date.today).first.completed
  end

  def all_daily_meals_completed?(pet)
    pet.nutritions.where(date: Date.today).first.completed &&
      pet.nutritions.where(date: Date.today).second.completed &&
      pet.nutritions.where(date: Date.today).third.completed
  end

  def weekly_appointments_upcoming?(pet)
    pet.appointments.where(datetime: Date.today..1.week.from_now).exists?
  end
end
