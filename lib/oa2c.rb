require 'rack/oauth2'
require 'mongoid'
require 'oa2c/engine'

module Oa2c
  mattr_accessor :user_model
  @@user_model = "User"

  def setup
    yield self
  end
end
