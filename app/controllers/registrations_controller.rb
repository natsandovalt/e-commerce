class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :name))
    @user.should_send_welcome_email = true

    if @user.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end