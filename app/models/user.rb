class User < ApplicationRecord
  has_secure_token :session_token

  has_one :habit, dependent: :destroy
  has_many :records, dependent: :destroy
  has_many :habit_logs, dependent: :destroy
end
