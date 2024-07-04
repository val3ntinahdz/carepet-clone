class VeterinariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @veterinaries = Veterinary.all
  end

  def show
    @veterinary = Veterinary.find(params[:id])
  end

  def new
    @veterinary = Veterinary.new
  end
end
