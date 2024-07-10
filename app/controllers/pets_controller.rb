class PetsController < ApplicationController
  before_action :set_pet, only: %i[show edit update destroy edit_vaccines update_vaccines]

  def index
    @pets = Pet.all
  end

  def show
    @applied_vaccines = @pet.vaccines
    @missing_vaccines = Vaccine.all - @applied_vaccines
    @conditions = @pet.conditions
    @allergies = @pet.allergies
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user
    if @pet.save
      redirect_to pet_path(@pet), notice: 'Pet added succesfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @pet.update(pet_params)
      redirect_to pet_path(@pet), notice: 'Pet was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy
    redirect_to pets_path, notice: 'Pet was successfully deleted.'
  end

  def edit_vaccines
    @vaccines = Vaccine.all
  end

  def update_vaccines
    @pet = Pet.find(params[:id])
    @pet.vaccine_ids = params[:pet][:vaccine_ids]
    if @pet.save
      redirect_to @pet, notice: 'Vaccines were successfully updated.'
    else
      @vaccines = Vaccine.all
      render :edit_vaccines
    end
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :pet_type, :breed, :birthday_date, :gender, :weight, :height, :color)
  end
end
