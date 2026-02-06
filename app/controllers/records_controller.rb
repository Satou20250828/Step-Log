class RecordsController < ApplicationController
  def index
    # あなた自身（ログインユーザー）のレコードを確定させる
    summary = RecordSummary.new(current_user)
    @total_recorded_days = summary.total_recorded_days
    @this_month_recorded_days = summary.this_month_recorded_days
    @recent_records = summary.recent_records
    @today_record = summary.today_record
    @records = summary.records_ordered
  end

  def create
    # Time.zone.today を使用して日付を固定
    @record = current_user.records.find_or_initialize_by(recorded_on: Time.zone.today)

    if @record.update(record_params)
      # result は enum なので文字列で返ってくるため、この message 判定は維持
      redirect_to root_path, notice: Record.notice_for(@record.result)
    else
      redirect_to root_path, alert: "記録の保存に失敗しました。"
    end
  end

  private

  def record_params
    params.require(:record).permit(:result)
  end

end
