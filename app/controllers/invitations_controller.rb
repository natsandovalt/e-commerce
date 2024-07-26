class InvitationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    form = UserInvitationForm.new(
      params.require(:user).permit(:email).to_h,
      send_copy: params[:send_copy],
      send_copy_to: current_user
    )
    
    if form.save
      redirect_to root_path
    else
      @user = form.user
      render :new, status: :unprocessable_entity
    end
  end
end