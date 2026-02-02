class ApplicationController < ActionController::Base
  before_action :set_current_user

  private

  def set_current_user
    # uuid を session_token に書き換え
    token = cookies.permanent[:user_uuid]

    @current_user = User.find_or_create_by!(session_token: token) do |user|
      user.session_token = SecureRandom.uuid
    end

    cookies.permanent[:user_uuid] = @current_user.session_token
  end
end