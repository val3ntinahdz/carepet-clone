class ServicesController < ApplicationController
  before_action :authenticate_user!

  def index
    # @veterinary = Veterinary.find(params[:veterinary_id])
    # @services = @veterinary.services
    @services = Service.all
  end

  def show
    @service = Service.find(params[:id])
    # @veterinary = @service.user
  end

  def new
    @veterinary = Veterinary.find(params[:veterinary_id])
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.veterinary_id = params[:veterinary_id]

    if @service.save
      redirect_to service_path(@service)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def service_params
    params.require(:service).permit(:name, :category, :description, :fee)
  end
end
