class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment, only: %i[show edit update destroy]

  def index
    # @appointments = []
    # current_user.pets.each do |pet|
    #   pet.appointments.each do |appointment|
    #     @appointments << appointment if appointment.status == 'Scheduled'
    #   end
    # end
    @upcoming_appointments = Appointment.joins(:pet).where(pets: { user_id: current_user.id }, status: 'Scheduled')
    @past_appointments = Appointment.joins(:pet).where(pets: { user_id: current_user.id }, status: 'Completed')
  end

  def show; end

  def edit; end

  def update
    if @appointment.update(appointment_params)
      redirect_to root_path, notice: 'Appointment updated successfully!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @service = Service.find(params[:service_id])
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @service = Service.find(params[:service_id])
    @appointment.service_id = @service.id

    if @appointment.save
      redirect_to appointment_path(@appointment), notice: 'Appointment scheduled successfully!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
    redirect_to root_path, notice: 'Appointment cancelled successfully.'
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:datetime, :reason, :comments, :fee, :status, :pet_id)
  end
end
