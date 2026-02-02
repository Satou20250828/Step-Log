class User < ApplicationRecord
  has_one :habit, dependent: :destroy
  validates :session_token, presence: true, uniqueness: true
  before_validation :generate_session_token, on: :create

  private
  def generate_session_token
    self.session_token ||= SecureRandom.uuid
  end
end
