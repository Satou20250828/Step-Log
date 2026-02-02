class Habit < ApplicationRecord
  belongs_to :user
  has_many :records, dependent: :destroy
  validates :name, presence: true
  validates :user_id, uniqueness: true
end