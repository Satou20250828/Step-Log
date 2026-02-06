# frozen_string_literal: true

require "rails_helper"

RSpec.describe Record do
  include ActiveSupport::Testing::TimeHelpers

  let(:user) { create(:user) }
  let(:today) { Date.new(2026, 2, 6) }

  before do
    travel_to(Time.zone.local(2026, 2, 6, 12, 0, 0))
  end

  after do
    travel_back
  end

  it "does not allow the same user to record twice on the same day" do
    create(:record, user: user, recorded_on: today)

    duplicate = build(:record, user: user, recorded_on: today)

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:recorded_on]).to include("今日はすでに記録済みです")
  end
end
