class DashboardController < ApplicationController
  def dashboard
    @pets = current_user.pets
  end
end
