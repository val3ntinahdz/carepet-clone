class VeterinariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_veterinary, only: %i[edit update]

  def index
    @veterinaries = Veterinary.all
  end

  def show
    @veterinary = Veterinary.find(params[:id])
  end

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
