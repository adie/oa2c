require 'rack/oauth2'
require 'mongoid'
require 'oa2c/engine'

module Oa2c
  mattr_accessor :user_model
  @@user_model = "User"

  mattr_accessor :authentication_method
  @@authentication_method = :authenticate_user!

  mattr_accessor :current_user_method
  @@current_user_method = :current_user

  def self.setup
    yield self
  end
end
