# why
class SessionsController < UnauthenticatedUserController
  skip_before_action :redirect_if_logged_in, only: :destroy

  def new
    @twitch_url = SessionsHelper.twitch_auth_url(session[:_state_token])
    if params['code'] && params['state']
      save_cookies(params)
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid Twitch auth'
      render :new
    end
  end

  private

  def save_cookies(params)
    cookies.encrypted[:twitch_code] = params['code']
    cookies.encrypted[:twitch_state] = params['state']
  end
end
