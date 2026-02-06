# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecordSummary do
  include ActiveSupport::Testing::TimeHelpers

  let(:user) { create(:user) }
  let(:today) { Date.new(2026, 2, 6) }

  before do
    travel_to(Time.zone.local(2026, 2, 6, 12, 0, 0))
  end

  after do
    travel_back
  end

  describe "#consecutive_days" do
    it "returns 3 when records exist for today, yesterday, and the day before" do
      create(:record, user: user, recorded_on: today)
      create(:record, user: user, recorded_on: today - 1)
      create(:record, user: user, recorded_on: today - 2)

      summary = described_class.new(user)

      expect(summary.consecutive_days).to eq(3)
    end

    it "returns 1 when today is recorded but yesterday is missing (streak broken)" do
      create(:record, user: user, recorded_on: today)
      create(:record, user: user, recorded_on: today - 2)

      summary = described_class.new(user)

      expect(summary.consecutive_days).to eq(1)
    end

    it "keeps the streak when today is missing but yesterday is recorded" do
      create(:record, user: user, recorded_on: today - 1)
      create(:record, user: user, recorded_on: today - 2)

      summary = described_class.new(user)

      expect(summary.consecutive_days).to eq(2)
    end
  end

  describe "#total_days" do
    it "returns 5 when there are 5 total records" do
      5.times do |i|
        create(:record, user: user, recorded_on: today - i)
      end

      summary = described_class.new(user)

      expect(summary.total_days).to eq(5)
    end
  end
end
