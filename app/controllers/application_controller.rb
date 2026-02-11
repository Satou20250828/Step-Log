class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :current_habit, :header_achieved_days

  def current_user
    @current_user ||= User.first_or_create!
  end

  def current_habit
    @current_habit ||= current_user.habit
  end

  def header_achieved_days
    return 0 unless current_habit
    return @total_recorded_days if defined?(@total_recorded_days) && !@total_recorded_days.nil?

    @header_achieved_days ||= current_user.records.achieved.count
  end
end
