class InvitationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email))
    @user.should_send_invitation = true

    if @user.save
      if params[:send_copy] == "1"
        UserMailer.invitation_copy(current_user, @user).deliver_later
      end
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end