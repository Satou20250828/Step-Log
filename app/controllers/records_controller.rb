class RecordsController < ApplicationController
  def index
    # あなた自身（ログインユーザー）のレコードを確定させる
    my_records = current_user.records
    # 1. 積み上げ日数：enumの名前ではなく、DBの数値(0と1)で直接カウントする
    @total_recorded_days = my_records.where(result: [0, 1]).count
    # 2. 今月の記録日数：Time.zone（日本時間などアプリ設定）を基準に、月初から月末までを明示
    target_range = Time.zone.now.beginning_of_month..Time.zone.now.end_of_month
    @this_month_recorded_days = my_records.where(recorded_on: target_range).count
    # 他の変数はこれに合わせて修正
    @recent_records = my_records.order(recorded_on: :desc).limit(7)
    @today_record = my_records.find_by(recorded_on: Time.zone.now.to_date)
    @records = my_records.order(recorded_on: :desc)
  end

  def create
    # Time.zone.today を使用して日付を固定
    @record = current_user.records.find_or_initialize_by(recorded_on: Time.zone.today)

    if @record.update(record_params)
      # result は enum なので文字列で返ってくるため、この message 判定は維持
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
    case result.to_s # 念のため文字列に変換して比較
    when "done"
      "完璧です！最高の積み上げですね！✨"
    when "a_little"
      "一歩前進！その少しの努力が未来を変えます！🌱"
    when "skipped"
      "今日はリフレッシュ！ゆっくり休んで、明日からまた一歩ずつ。🍵"
    else
      "記録しました！"
    end
  end
end
