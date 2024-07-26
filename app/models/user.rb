class User < ApplicationRecord
  attribute :should_send_welcome_email, :boolean

  after_create_commit :send_welcome_email, if: :should_send_welcome_email
  
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, if: :confirmed?
  
  def confirmed?
    confirmed_at.present?
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver_later
  end
end
