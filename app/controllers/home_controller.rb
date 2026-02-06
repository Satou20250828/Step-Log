class HomeController < ApplicationController
  def index
    # ログインしていない場合の考慮
    return unless current_user

    summary = RecordSummary.new(current_user)
    @total_recorded_days = summary.total_recorded_days
    @this_month_recorded_days = summary.this_month_recorded_days
    @recent_records = summary.recent_records
    @today_record = summary.today_record
  end
end
