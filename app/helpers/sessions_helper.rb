# frozen_string_literal: true

# This is really a general Twitch helper. maybe move to Twitch model?
module SessionsHelper
  TWITCH_AUTH_BASE = 'https://id.twitch.tv/'
  TWITCH_API_BASE = 'https://api.twitch.tv/kraken/'
  TWITCH_SCOPES = 'scope=user_read+user_subscriptions'
  # Jack AM
  CHANNEL_ID = '108392761'

  def self.twitch_auth_url(state_token)
    tok = Base64.urlsafe_encode64(state_token)
    "#{TWITCH_AUTH_BASE}oauth2/authorize?client_id=#{ENV['TWITCH_CLIENT_ID']}&redirect_uri=#{ENV['REDIRECT_URL']}&response_type=code&#{TWITCH_SCOPES}&state=#{tok}"
  end

  def self.twitch_auth_user(twitch_code)
    "#{TWITCH_AUTH_BASE}oauth2/token?client_id=#{ENV['TWITCH_CLIENT_ID']}&client_secret=#{ENV['TWITCH_CLIENT_SECRET']}&code=#{twitch_code}&grant_type=authorization_code&redirect_uri=#{ENV['REDIRECT_URL']}"
  end

  def self.twitch_user(twitch_user_code)
    conn = Faraday.new("#{TWITCH_API_BASE}user")
    conn.get do |req|
      req.headers['Accept'] = 'application/vnd.twitchtv.v5+json'
      req.headers['Client-ID'] = ENV['TWITCH_CLIENT_ID']
      req.headers['Authorization'] = "OAuth #{twitch_user_code}"
    end
  end

  def self.twitch_user_subscriptions(twitch_user_code, user_id)
    conn = Faraday.new("#{TWITCH_API_BASE}users/#{user_id}/subscriptions/#{CHANNEL_ID}")
    conn.get do |req|
      req.headers['Accept'] = 'application/vnd.twitchtv.v5+json'
      req.headers['Client-ID'] = ENV['TWITCH_CLIENT_ID']
      req.headers['Authorization'] = "OAuth #{twitch_user_code}"
    end
  end
end
