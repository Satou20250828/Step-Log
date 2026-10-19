class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # ユーザーを見分ける合言葉（session_token）を預けるCookieの名前
  USER_COOKIE_KEY = :session_token

  helper_method :current_user, :current_habit, :header_achieved_days

  # 閲覧用：Cookieの合言葉でユーザーを探す。見つからなければ、まだ保存しない仮のユーザーを返す
  # （閲覧や死活監視のアクセスでユーザーが増えないようにするため）
  def current_user
    @current_user ||= find_user_from_cookie || User.new
  end

  def current_habit
    @current_habit ||= current_user.habit
  end

  def header_achieved_days
    return 0 unless current_habit
    return @total_recorded_days if defined?(@total_recorded_days) && !@total_recorded_days.nil?

    @header_achieved_days ||= current_user.records.achieved.count
  end

  private

  # 登録・記録用：ユーザーがまだ保存されていなければ保存し、合言葉をCookieに預ける
  def current_user!
    user = current_user
    if user.new_record?
      user.save!
      cookies.signed.permanent[USER_COOKIE_KEY] = {
        value: user.session_token,
        httponly: true,
        same_site: :lax
      }
    end
    user
  end

  def find_user_from_cookie
    token = cookies.signed[USER_COOKIE_KEY]
    User.find_by(session_token: token) if token.present?
  end
end
