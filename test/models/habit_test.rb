require "test_helper"

class HabitTest < ActiveSupport::TestCase
  test "total_achieved_days excludes skipped records" do
    habit = habits(:one)
    user = habit.user

    user.records.create!(recorded_on: Date.new(2026, 2, 3), result: :done)
    user.records.create!(recorded_on: Date.new(2026, 2, 4), result: :skipped)

    assert_equal 2, habit.total_achieved_days
  end
end
