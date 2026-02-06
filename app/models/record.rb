class Record < ApplicationRecord
  belongs_to :user
  # resultの定義を0,1,2で固定
  enum :result, { done: 0, a_little: 1, skipped: 2 }
  NOTICE_MESSAGES = {
    "done" => "完璧です！最高の積み上げですね！✨",
    "a_little" => "一歩前進！その少しの努力が未来を変えます！🌱",
    "skipped" => "今日はリフレッシュ！ゆっくり休んで、明日からまた一歩ずつ。🍵"
  }.freeze
  # 積み上げ（できた・少し）
  scope :achieved, -> { where(result: [:done, :a_little]) }
  # 今月（記録日ベース）
  scope :this_month, -> { where(recorded_on: Time.zone.today.all_month) }
  validates :recorded_on, uniqueness: { scope: :user_id }

  def self.notice_for(result)
    NOTICE_MESSAGES[result.to_s] || "記録しました！"
  end
end
