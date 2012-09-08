require 'rack/oauth2'
require 'mongoid'
require 'oa2c/engine'

module Oa2c
  autoload :Authentication, 'oa2c/authentication'
  autoload :Middleware, 'oa2c/middleware'

  mattr_accessor :user_model
  @@user_model = "User"

  mattr_accessor :authentication_method
  @@authentication_method = :authenticate_user!

  mattr_accessor :login_method
  @@login_method = :sign_in

  mattr_accessor :current_user_method
  @@current_user_method = :current_user

  mattr_accessor :find_user_for_password_authentication
  @@find_user_for_password_authentication = proc {|username, password|
    user = Oa2c.user_model.constantize.where(email: username).first
    user if user.valid_password? password
  }

  mattr_accessor :auto_approve
  @@auto_approve = false

  def self.setup
    yield self
  end
end
