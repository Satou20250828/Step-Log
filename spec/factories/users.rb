# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:session_token) { |n| "session-token-#{n}" }
  end
end
