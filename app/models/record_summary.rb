class RecordSummary
  def initialize(user, date: Time.zone.today, recent_limit: 7)
    @user = user
    @date = date
    @recent_limit = recent_limit
  end

  def total_recorded_days
    summary_counts[:total_recorded_days]
  end

  def total_days
    records.count
  end

  def consecutive_days
    dates = records_ordered.pluck(:recorded_on)
    return 0 if dates.empty?

    first = dates.first
    return 0 if first < (@date - 1)

    streak = 1
    dates.drop(1).each do |date|
      break unless date == (first - 1)

      streak += 1
      first = date
    end

    streak
  end

  def this_month_recorded_days
    summary_counts[:this_month_recorded_days]
  end

  def recent_records
    @recent_records ||= records.order(recorded_on: :desc).limit(@recent_limit).to_a
  end

  def today_record
    @today_record ||= recent_records.find { |record| record.recorded_on == @date }
  end

  def records_ordered
    records.order(recorded_on: :desc)
  end

  private

  def records
    @records ||= @user.records
  end

  def summary_counts
    @summary_counts ||= begin
      achieved_values = [
        Record.results.fetch("done"),
        Record.results.fetch("a_little")
      ].join(",")
      month_start = Record.connection.quote(@date.beginning_of_month)
      month_end = Record.connection.quote(@date.end_of_month)

      total_recorded_days, this_month_recorded_days = records.pick(
        Arel.sql("COUNT(*) FILTER (WHERE result IN (#{achieved_values}))"),
        Arel.sql("COUNT(*) FILTER (WHERE recorded_on BETWEEN #{month_start} AND #{month_end})")
      )

      {
        total_recorded_days: total_recorded_days.to_i,
        this_month_recorded_days: this_month_recorded_days.to_i
      }
    end
  end
end
