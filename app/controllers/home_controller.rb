class HomeController < ApplicationController
  def index
    @today_record = current_user.records.find_by(recorded_on: Date.current)
    @recent_records = current_user.records.order(recorded_on: :desc).limit(7)
    @total_recorded_days = current_user.records.where.not(result: :skipped).count
    @this_month_recorded_days = current_user.records
                                      .where(recorded_on: Date.current.beginning_of_month..Date.current)
                                      .where.not(result: :skipped)
                                      .count
  end
end
