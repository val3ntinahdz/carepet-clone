class ServicesController < ApplicationController
  def index
    if current_user.veterinary.present?
      @services = current_user.veterinary.services
    else
      render_map_and_search_results
    end
  end

  def show
    @service = Service.find(params[:id])
    @veterinary = @service.veterinary
    @appointments = Appointment.where(service_id: @service.id).where("datetime >= ?", DateTime.now).order(:datetime)
    # @user_location = [{
    #   lat: current_user.latitude,
    #   lng: current_user.longitude,
    # }]

    # @veterinary_location = [{
    #   lat: @veterinary.user.latitude,
    #   lng: @veterinary.user.longitude,
    # }]
  end

  def new
    @veterinary = Veterinary.find(params[:veterinary_id])
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.veterinary_id = params[:veterinary_id]

    if @service.save
      redirect_to services_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def render_map_and_search_results
    @veterinaries = []

    if params[:query].present?
      @services = Service.search_by(params[:query])
      @veterinaries = @services.map { |service| service.veterinary }
    else
      @services = Service.all
    end

    @markers = @veterinaries.map do |veterinary|
      {
        lat: veterinary.user.latitude,
        lng: veterinary.user.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {veterinary: veterinary}),
        marker_html: render_to_string(partial: "marker", locals: { type: :veterinary })
      }
    end

    if current_user.latitude.present? && current_user.longitude.present?
      @markers << {
        lat: current_user.latitude,
        lng: current_user.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { user: current_user }),
        marker_html: render_to_string(partial: "marker", locals: { type: :user })
      }
    end
  end

  def service_params
    params.require(:service).permit(:name, :category, :description, :fee)
  end
end
