module Oa2c
  class RefreshToken
    include Mongoid::Document
    include OAuth2Token

    self.default_lifetime = 1.month
    has_many :access_tokens, autosave: true
  end
end

