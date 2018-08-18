# frozen_string_literal: true

# OK
class WelcomeController < AuthenticatedUserController
  # show the subscriber data
  def index
    
    @resp = get_twitch_user_auth(cookies.encrypted[:twitch_code])
    redirect_to login_path if @resp['status'] == 400

    # Rails.logger.error("get status is #{@resp['status']}")
    # redirect_to login_path if @resp['status'] != 200
    @user = JSON.parse(SessionsHelper.twitch_user(@resp['access_token']).body)
    # 87824738
    cookies.encrypted[:twitch_user_id] = @user['_id']
    @user['id'] = cookies.encrypted[:twitch_user_id]
    @subs = JSON.parse(SessionsHelper.twitch_user_subscriptions(@resp['access_token'], cookies.encrypted[:twitch_user_id]).body)
  end

  private

  def get_twitch_user_auth(twitch_code)
    resp = Faraday.post(SessionsHelper.twitch_auth_user(twitch_code))
    JSON.parse(resp.body)
  end
end
