class InvitationForm < ApplicationForm
  attribute :email
  attribute :send_copy, :boolean

  attr_accessor :sender

  validates :email, presence: true

  after_commit :deliver_invitation
  after_commit :deliver_invitation_copy, if: :send_copy

  private

    attr_reader :user

    def submit!
      @user = User.new(email: email)
      user.save!
      deliver_notifications!
    end

    def deliver_invitation
      UserMailer.invite(user).deliver_later
    end

    def deliver_invitation_copy
      UserMailer.invite_copy(sender, user).deliver_later if sender.present?
    end
end
