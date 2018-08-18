# not needed
class WebController < ApplicationController
  helper_method :logged_in?

  private

  def logged_in?
    user_signed_in?
  end
end
