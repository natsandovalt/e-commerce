class RegistrationForm < ApplicationForm
  attribute :name
  attribute :email

  validates :name, presence: true
  validate :user_is_valid

  # after_commit :deliver_welcome

  def initialize(...)
    super
    @user = User.new(email: email, name: name)
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

    def deliver_welcome
      UserMailer.welcome(user).deliver_later
    end
end
