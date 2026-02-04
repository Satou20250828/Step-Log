class RecordsController < ApplicationController
  def create
    @record = current_user.records.find_or_initialize_by(recorded_on: Date.current)

    if @record.update(record_params)
      redirect_to root_path, notice: notice_message(@record.result)
    else
      redirect_to root_path, alert: "記録の保存に失敗しました。"
    end
  end

  private

  def record_params
    params.require(:record).permit(:result)
  end

  def notice_message(result)
    case result
    when "done"
      "完璧です！最高の積み上げですね！✨"
    when "a_little"
      "一歩前進！その少しの努力が未来を変えます！🌱"
    when "skipped"
      "今日はリフレッシュ！ゆっくり休んで、明日からまた一歩ずつ。🍵"
    end
  end
end
