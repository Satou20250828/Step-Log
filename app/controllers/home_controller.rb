class HomeController < ApplicationController
  def index
    # ログインしていない場合の考慮
    return unless current_user

    my_records = current_user.records
    @total_recorded_days = my_records.where(result: [0, 1]).count
    target_range = Time.zone.now.beginning_of_month..Time.zone.now.end_of_month
    @this_month_recorded_days = my_records.where(recorded_on: target_range).count
    @recent_records = my_records.order(recorded_on: :desc).limit(7)
    @today_record = my_records.find_by(recorded_on: Time.zone.now.to_date)
  end
end
