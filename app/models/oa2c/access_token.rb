require 'oa2c/oauth2_token'
module Oa2c
  class AccessToken
    include Mongoid::Document
    include OAuth2Token

    belongs_to :refresh_token, class_name: "Oa2c::RefreshToken"

    def to_bearer_token(with_refresh_token = false)
      Rack::OAuth2::AccessToken::Bearer.new(access_token: token, expires_in: expires_in).tap do |bearer_token|
        if with_refresh_token
          bearer_token.refresh_token = create_refresh_token(user: user, client: client).token
        end
      end
    end

    private

    def setup
      super
      if refresh_token
        self.user = refresh_token.user
        self.client = refresh_token.client
        self.expires_at = [expires_at, refresh_token.expires_at].min
      end
    end
  end
end

