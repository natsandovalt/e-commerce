class RegistrationsController < ApplicationController
  def new
    @registration_form = RegistrationForm.new
  end

  def create
    @registration_form = RegistrationForm.from(params.require(:registration))

    if @registration_form.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end