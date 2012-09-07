module Oa2c
  class Middleware < Rack::OAuth2::Server::Resource::Bearer
    def initialize(app, realm = nil, &block)
      block ||= proc { |req|
        Oa2c::AccessToken.valid.where(token: req.access_token).first || req.invalid_token!
      }
      super app, realm, &block
    end
  end
end
