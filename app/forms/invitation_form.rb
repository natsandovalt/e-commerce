class InvitationForm < ApplicationForm
  attribute :email
  attribute :send_copy, :boolean

  attr_accessor :sender

  validate :user_is_valid 

  # after_commit :deliver_invitation
  # after_commit :deliver_invitation_copy, if: :send_copy

  def initialize(...)
    super
    @user = User.new(email: email)
  end

  private

    attr_reader :user

    def submit!
      user.save!
    end

    def user_is_valid
      return if user.valid?
      
      merge_errors!(user)
    end

    def deliver_invitation
      UserMailer.invite(user).deliver_later
    end

    def deliver_invitation_copy
      UserMailer.invite_copy(sender, user).deliver_later if sender.present?
    end
end
