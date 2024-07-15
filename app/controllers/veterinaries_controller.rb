class VeterinariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_veterinary, only: %i[show edit update]

  def index
    # @veterinaries = Veterinary.all
    nearby_veterinaries = User.joins(:veterinary).near([current_user.latitude, current_user.longitude], 10, units: :km).order(distance: :asc)
    @nearby_veterinaries = nearby_veterinaries.map(&:veterinary) # => array of vet objects, equivalent to (map { |near| near.veterinary})
  end

  def show; end

  def new
    @veterinary = Veterinary.new
  end

  def edit; end

  def update
    @veterinary.update(veterinary_params)
    redirect_to profile_path
  end

  private

  def set_veterinary
    @veterinary = Veterinary.find(params[:id])
  end

  def veterinary_params
    params.require(:veterinary).permit(:dni, :specialization)
  end
end
