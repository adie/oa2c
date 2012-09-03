module Oa2c
  class AuthorizationsController < ActionController::Base
    # before_filter :authorize, except: :token

    rescue_from Rack::OAuth2::Server::Authorize::BadRequest do |e|
      @error = e
      render :error, status: e.status
    end

    def new
      respond(*authorize_endpoint.call(request.env))
    end

    def create
      respond(*authorize_endpoint(true).call(request.env))
    end

    def token
      token_endpoint.call(request.env)
    end

    private

    def respond(status, header, response)
      ["WWW-Authenticate"].each do |key|
        headers[key] = header[key] if header[key].present?
      end
      if response.redirect?
        redirect_to header['Location']
      else
        render :new
      end
    end

    def authorize_endpoint(allow_approval = false)
      Rack::OAuth2::Server::Authorize.new do |req, res|
        @client = Client.where(identifier: req.client_id).first || req.bad_request!
        res.redirect_uri = @redirect_uri = req.verify_redirect_uri!(@client.redirect_uri)
        if allow_approval
          if params[:approve]
            case req.response_type
            when :code
              authorization_code = current_user.authorization_codes.create(client_id: @client.id, redirect_uri: res.redirect_uri)
              res.code = authorization_code.token
            when :token
              res.access_token = current_user.access_tokens.create(client_id: @client.id).to_bearer_token
            end
            res.approve!
          else
            req.access_denied!
          end
        else
          @response_type = req.response_type
        end
      end
    end

    def token_endpoint
      Rack::OAuth2::Server::Token.new do |req, res|
        client = Client.where(identifier: req.client_id).first || req.invalid_client!
        client.secret == req.client_secret || req.invalid_client!
        case req.grant_type
        when :authorization_code
          code = AuthorizationCode.valid.where(token: req.code).first
          req.invalid_grant! if code.blank? || code.redirect_uri != req.redirect_uri
          res.access_token = code.access_token.to_bearer_token(:with_refresh_token)
        # when :password
        #   # NOTE: password is not hashed in this sample app. Don't do the same on your app.
        #   # FIXME
        #   account = Account.find_by_username_and_password(req.username, req.password) || req.invalid_grant!
        #   res.access_token = account.access_tokens.create(:client => client).to_bearer_token(:with_refresh_token)
        when :client_credentials
          # NOTE: client is already authenticated here.
          res.access_token = client.access_tokens.create.to_bearer_token
        when :refresh_token
          refresh_token = client.refresh_tokens.valid.wehre(token: req.refresh_token).first
          req.invalid_grant! unless refresh_token
          res.access_token = refresh_token.access_tokens.create.to_bearer_token
        else
          # NOTE: extended assertion grant_types are not supported yet.
          req.unsupported_grant_type!
        end
      end
    end

  end
end
