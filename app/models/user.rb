class User < ApplicationRecord
  # 1人につき、1つの「旗印（習慣）」
  has_one :habit, dependent: :destroy
  # 1人につき、たくさんの「足跡（記録）」
  has_many :records, dependent: :destroy
  # 1人につき、たくさんの「物語（履歴）」
  has_many :habit_logs, dependent: :destroy
end
