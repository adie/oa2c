class ApplicationController < ActionController::Base
  protect_from_forgery

  def ok
    render :text => 'ok'
  end
end
