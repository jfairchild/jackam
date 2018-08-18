# frozen_string_literal: true

# logged_in means we have a Twitch token
class AuthenticatedUserController < WebController
  before_action :require_logged_in_user!

  private

  def require_logged_in_user!
    return if session[:_state_token] == Base64.urlsafe_decode64(cookies.encrypted[:twitch_state])
    redirect_to login_path
  end
end
