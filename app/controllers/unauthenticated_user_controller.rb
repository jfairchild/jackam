# ok
class UnauthenticatedUserController < WebController
  before_action :redirect_if_logged_in, :state_token

  private

  def redirect_if_logged_in
    redirect_to root_path if logged_in?
  end

  def state_token
    session[:_state_token] ||= SecureRandom.base64(AUTHENTICITY_TOKEN_LENGTH)
  end
end
