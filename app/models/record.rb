class Record < ApplicationRecord
  belongs_to :user
  
  # 3択の定義（enumを使うと数字を言葉で扱えます）
  enum :result, { done: 0, a_little: 1, skipped: 2 }

  validates :recorded_on, presence: true
  validates :result, presence: true
end
