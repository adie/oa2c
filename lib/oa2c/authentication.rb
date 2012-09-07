module Oa2c
  module Authentication
    def current_token
      @current_token
    end

    def current_client
      @current_client
    end

    def require_oauth_token
      @current_token = request.env[Rack::OAuth2::Server::Resource::ACCESS_TOKEN]
      raise Rack::OAuth2::Server::Resource::Bearer::Unauthorized unless @current_token
    end

    def require_oauth_user_token
      require_oauth_token
      raise Rack::OAuth2::Server::Resource::Bearer::Unauthorized.new(:invalid_token, 'User token is required') unless current_token.user
      send Oa2c.login_method, current_token.user
    end

    def require_oauth_client_token
      require_oauth_token
      raise Rack::OAuth2::Server::Resource::Bearer::Unauthorized.new(:invalid_token, 'Client token is required') if current_token.user
      @current_client = current_token.client
    end
  end
end

