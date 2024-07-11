class VaccinationsController < ApplicationController
  before_action :set_pet, only: %i[new create]

  def new
    @vaccination = Vaccination.new
  end

  def create
    @vaccination = Vaccination.new(vaccination_params)
    @vaccination.pet = @pet
    if @vaccination.save
      respond_to do |format|
        format.html { redirect_to pet_path(@pet), notice: 'Vaccine added succesfully' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def vaccination_params
    params.require(:vaccination).permit(:date, :comments, :vaccine_id)
  end
end
