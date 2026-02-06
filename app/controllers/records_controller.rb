class RecordsController < ApplicationController
  def index
    # あなた自身（ログインユーザー）のレコードを確定させる
    load_summary
  end

  def create
    # Time.zone.today を使用して日付を固定
    @record = current_user.records.find_or_initialize_by(recorded_on: Time.zone.today)
    @record.assign_attributes(record_params)

    if @record.save
      # result は enum なので文字列で返ってくるため、この message 判定は維持
      redirect_to root_path, notice: Record.notice_for(@record.result)
    else
      log_record_error(@record)
      flash.now[:alert] = @record.errors.full_messages.first || "記録の保存に失敗しました。"
      load_summary
      render :index, status: :unprocessable_entity
    end
  end

  private

  def record_params
    params.require(:record).permit(:result)
  end

  def load_summary
    summary = RecordSummary.new(current_user)
    @total_recorded_days = summary.total_recorded_days
    @consecutive_days = summary.consecutive_days
    @this_month_recorded_days = summary.this_month_recorded_days
    @recent_records = summary.recent_records
    @today_record = summary.today_record
    @records = summary.records_ordered
  end

  def log_record_error(record)
    Rails.logger.error(
      [
        "[RecordSaveFailed]",
        "user_id=#{current_user.id}",
        "recorded_on=#{record.recorded_on}",
        "result=#{record.result}",
        "errors=#{record.errors.full_messages.join(', ')}"
      ].join(" ")
    )
  end
end
