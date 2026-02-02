class Record < ApplicationRecord
  belongs_to :habit
  enum :status, { done: "done", partial: "partial", not_done: "not_done" }, default: "done"
  validates :recorded_on, presence: true
  validates :status, presence: true, inclusion: { in: [ :done, :partial, :not_done ] }
  validates :recorded_on, uniqueness: { scope: :habit_id }
end
