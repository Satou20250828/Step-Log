class Habit < ApplicationRecord
  belongs_to :user
  has_many :records, through: :user

  def total_achieved_days
    records.where.not(result: :skipped).count
  end
end
