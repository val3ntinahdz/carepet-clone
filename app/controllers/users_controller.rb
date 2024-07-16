class UsersController < ApplicationController
  def profile
    @pets = current_user.pets
    @veterinary = current_user.veterinary
  end
end
