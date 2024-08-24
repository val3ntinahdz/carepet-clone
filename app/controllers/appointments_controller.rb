class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment, only: %i[show edit update destroy update_status]

  def index
    if current_user.veterinary.present?
      @veterinary_appointments = fetch_veterinary_appointments
    else
      @upcoming_appointments = fetch_user_appointments('Scheduled')
      @completed_appointments = fetch_user_appointments('Completed')
    end
  end

  def show; end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def update
    if @appointment.update(appointment_params)
      respond_to do |format|
        format.html { redirect_to @appointment, notice: 'Appointment was successfully rescheduled.' }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('appointment_form', partial: 'edit_form', locals: { appointment: @appointment }) }
      end
    end
  end

  def update_status
    @appointment.update(status: params[:status])
    redirect_to appointments_path, notice: 'Appointment status updated sucessfully'
  end

  def new
    @service = Service.find(params[:service_id])
    @appointment = Appointment.new
    @appointments = @service.veterinary.user.appointments
    @booked_dates = @appointments.pluck(:datetime).map { |datetime| datetime.strftime("%Y-%m-%dT%H:%M:%S")}
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @service = Service.find(params[:service_id])
    @appointment.service_id = @service.id
    @appointment.status = "Scheduled"

    if @appointment.save
      redirect_to appointment_path(@appointment), notice: 'Appointment scheduled successfully!'
    else
      @booked_dates = Appointment.pluck(:datetime).map { |datetime| datetime.strftime("%Y-%m-%dT%H:%M:%S")}
      @appointments = @service.veterinary.user.appointments
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: 'Appointment cancelled successfully.'
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:datetime, :reason, :comments, :fee, :status, :pet_id)
  end

  def fetch_veterinary_appointments
    Appointment.joins(service: :veterinary).where(services: { veterinary: current_user.veterinary }).where(status: 'Scheduled')
  end

  def fetch_user_appointments(status)
    Appointment.joins(:pet).where(pets: { user_id: current_user.id }).where(status: status)
  end
end
