# frozen_string_literal: true

FactoryBot.define do
  factory :record do
    association :user
    recorded_on { Date.today }
  end
end
