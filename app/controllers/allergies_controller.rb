class AllergiesController < ApplicationController
  before_action :set_pet, only: %i[new create]
  before_action :set_allergy, only: %i[show edit update destroy]

  def new
    @allergy = Allergy.new
  end

  def show; end

  def create
    @allergy = Allergy.new(allergy_params)
    @allergy.pet = @pet
    if @allergy.save
      respond_to do |format|
        format.html { redirect_to pet_path(@pet), notice: 'Allergy added succesfully' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream { render partial: 'allergies/edition2', locals: { allergy: @allergy } }
    end
  end

  def update
    if @allergy.update(allergy_params)
      respond_to do |format|
        format.html { redirect_to pet_path(@pet), notice: 'Allergy updated succesfully' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:_top, partial: 'allergies/allergy', locals: { allergy: @allergy })
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @allergy.destroy
    respond_to do |format|
      format.html { redirect_to pet_path(@pet), notice: "Allergy was successfully destroyed" }
      format.turbo_stream
    end
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_allergy
    @allergy = Allergy.find(params[:id])
    @pet = @allergy.pet
  end

  def allergy_params
    params.require(:allergy).permit(:detected_on, :severity, :reactions, :comments, :allergen_id)
  end
end
