# frozen_string_literal: true

# not needed
class WebController < ApplicationController
  helper_method :logged_in?

  private

  def logged_in?
    false if cookies.encrypted[:twitch_code].nil?
  end
end
