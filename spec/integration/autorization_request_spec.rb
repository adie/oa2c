require 'spec_helper'
require 'rack/oauth2'

describe "Authorization request" do
  let(:client) { Oa2c::Client.create redirect_uri: 'http://example.com/callback' }

  let(:conn) do
    Rack::OAuth2::Client.new(
      identifier: client.identifier,
      secret: client.secret,
      redirect_uri: client.redirect_uri,
      host: 'example.com'
    )
  end

  context "token request" do
    before { get conn.authorization_uri(response_type: :token) }
    it { response.should be_success }
  end

  context "code request" do
    before { get conn.authorization_uri }
    it { response.should be_success }
  end
end
