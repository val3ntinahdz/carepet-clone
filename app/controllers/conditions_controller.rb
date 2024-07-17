class ConditionsController < ApplicationController
  before_action :set_pet, only: %i[new create]
  before_action :set_condition, only: %i[show edit update destroy]

  def new
    @condition = Condition.new
  end

  def show; end

  def create
    @condition = Condition.new(condition_params)
    @condition.pet = @pet
    if @condition.save
      respond_to do |format|
        format.html { redirect_to pet_path(@pet), notice: 'Condition added succesfully' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream { render partial: 'conditions/edition1', locals: { condition: @condition } }
    end
  end

  def update
    if @condition.update(condition_params)
      respond_to do |format|
        format.html { redirect_to pet_path(@pet), notice: 'Condition updated succesfully' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:_top, partial: 'conditions/condition', locals: { condition: @condition })
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @condition.destroy
    respond_to do |format|
      format.html { redirect_to pet_path(@pet), notice: "Condition was successfully destroyed" }
      format.turbo_stream
    end
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_condition
    @condition = Condition.find(params[:id])
    @pet = @condition.pet
  end

  def condition_params
    params.require(:condition).permit(:diagnosis_date, :recovery_date, :comment, :disease_id)
  end
end
