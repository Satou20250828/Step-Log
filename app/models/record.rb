class Record < ApplicationRecord
  belongs_to :user
  enum :result, { done: 0, a_little: 1, skipped: 2 }
end
