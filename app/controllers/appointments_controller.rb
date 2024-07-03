class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @service = Service.find(params[:service_id])
    @appointments = @service.appointments
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

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
    redirect_to root_path, notice: 'Appointment cancelled successfully!'
  end

  def my_appointments
    @my_appointments = current_user.appointments
  end

  def veterinary_appointments
    # @veterinary_apppointments = []
    # current_user.services.each do |service|
    #   service.appointments.each do |appointment|
    #     @veterinary_appointments << appointment
    #   end
    # end
    @appointments = Appointment.joins(:service).where(services: { veterinary_id: current_user.id})
  end

  private

  def appointment_params
    params.require(:appointment).permit(:datetime, :reason, :comments, :fee, :pet_id)
  end
end
