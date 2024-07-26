class UserInvitationForm
  attr_reader :user, :send_copy, :sender

  def initialize(params, send_copy: false, sender: nil)
    @user = User.new(params)
    @send_copy = send_copy.in?(%w[1 t true])
    @sender = sender
  end

  def save
    validate!
    return false if user.errors.any?

    user.save!
    deliver_notifications!
  end

  private

    def validate!
      user.errors.add(:email, :blank) if user.email.blank?
    end

    def deliver_notifications!
      UserMailer.invite(user).deliver_later
      if send_copy
        UserMailer.invite_copy(sender, user).deliver_later
      end
    end
end