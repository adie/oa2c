module Oa2c
  class AuthorizationCode
    include Mongoid::Document
    include OAuth2Token

    def access_token
      @access_token ||= expire! && user.access_tokens.create(client: client)
    end
  end
end
