class RecordSummary
  def initialize(user, date: Time.zone.today, recent_limit: 7)
    @user = user
    @date = date
    @recent_limit = recent_limit
  end

  def total_recorded_days
    records.achieved.count
  end

  def this_month_recorded_days
    records.this_month.count
  end

  def recent_records
    records.order(recorded_on: :desc).limit(@recent_limit)
  end

  def today_record
    records.find_by(recorded_on: @date)
  end

  def records_ordered
    records.order(recorded_on: :desc)
  end

  private

  def records
    @records ||= @user.records
  end
end
