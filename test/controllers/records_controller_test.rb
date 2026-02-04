require "test_helper"

class RecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index in descending order" do
    user = users(:one)
    habit = habits(:one)

    user.records.create!(recorded_on: Date.new(2026, 2, 3), result: :done)
    user.records.create!(recorded_on: Date.new(2026, 2, 4), result: :skipped)

    get records_url

    assert_response :success
    assert_select "h1", text: "行動履歴"

    expected_dates = habit.records.order(recorded_on: :desc).pluck(:recorded_on).map { |d| d.strftime("%Y/%m/%d") }
    body = @response.body

    expected_dates.each_cons(2) do |first, second|
      assert_operator body.index(first), :<, body.index(second)
    end
  end

  test "shows empty message when no records" do
    users(:one).records.delete_all

    get records_url

    assert_response :success
    assert_select "p", text: "まだ記録がありません"
  end
end
