class InvitationsController < ApplicationController
  def new
    @invitation_form = InvitationForm.new
  end

  def create
    @invitation_form = InvitationForm.from(params.require(:invitation))
    @invitation_form.sender = current_user
    
    if @invitation_form.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end
