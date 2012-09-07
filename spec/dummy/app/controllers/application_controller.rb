class ApplicationController < ActionController::Base
  include Oa2c::Authentication
  protect_from_forgery

  before_filter :require_oauth_client_token, :only => [:protected_client]
  before_filter :require_oauth_user_token, :only => [:protected_user]
  before_filter :require_oauth_token, :only => [:protected]

  def ok
    render :text => 'ok'
  end

  def protected_client
    render :text => 'protected client!'
  end

  def protected_user
    render :text => 'protected user!'
  end

  def protected
    render :text => 'protected!'
  end
end
