class VaccinationsController < ApplicationController
  before_action :set_pet, only: %i[new create]
  before_action :set_vaccination, only: %i[show edit update destroy]

  def new
    @vaccination = Vaccination.new
  end

  def show; end

  def create
    @vaccination = Vaccination.new(vaccination_params)
    @vaccination.pet = @pet
    if @vaccination.save
      respond_to do |format|
        format.html { redirect_to pet_path(@pet), notice: 'Vaccination added succesfully' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream { render partial: 'vaccinations/edition', locals: { vaccination: @vaccination } }
    end
  end

  def update
    if @vaccination.update(vaccination_params)
      respond_to do |format|
        format.html { redirect_to pet_path(@pet), notice: 'Vaccination updated succesfully' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:_top, partial: 'vaccinations/vaccination', locals: { vaccination: @vaccination })
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @vaccination.destroy
    respond_to do |format|
      format.html { redirect_to pet_path(@pet), notice: "Vaccination was successfully destroyed" }
      format.turbo_stream
    end
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_vaccination
    @vaccination = Vaccination.find(params[:id])
    @pet = @vaccination.pet
  end

  def vaccination_params
    params.require(:vaccination).permit(:date, :comments, :vaccine_id)
  end
end
