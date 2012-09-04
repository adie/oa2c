class ApplicationController < ActionController::Base
  protect_from_forgery

  def callback
    render :text => 'ok'
  end
end
