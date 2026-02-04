class Record < ApplicationRecord
  belongs_to :user
  # resultの定義を0,1,2で固定
  enum :result, { done: 0, a_little: 1, skipped: 2 }
  # 積み上げ（できた・少し）
  scope :achieved, -> { where(result: [:done, :a_little]) }
  # 今月（記録日ベース）
  scope :this_month, -> { where(recorded_on: Time.zone.today.all_month) }
  validates :recorded_on, uniqueness: { scope: :user_id }
end
