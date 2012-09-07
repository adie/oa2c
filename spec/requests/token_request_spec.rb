require 'spec_helper'
require 'rack/oauth2'

describe "Token request" do
  let(:client) { FactoryGirl.create :client }

  let(:server) { Capybara::Server.new(Capybara.app).boot }
  let(:oauth) do
    Rack::OAuth2::Client.new(
      identifier: client.identifier,
      secret: client.secret,
      redirect_uri: client.redirect_uri,
      host: server.host,
      port: server.port,
      scheme: 'http'
    )
  end

  let(:user) { FactoryGirl.create :user }

  context "authorization code" do
    let(:code) { FactoryGirl.create :authorization_code, user: user }
    before { oauth.authorization_code = code.token }
    subject { oauth.access_token! }
    let(:user_token) { user.access_tokens.last }

    its(:access_token) { should == user_token.token }
    its(:refresh_token) { should == user_token.refresh_token.token }
  end

  context "client credentials" do
    subject { oauth.access_token! }
    let(:client_token) { client.access_tokens.last }

    its(:access_token) { should == client_token.token }
    its(:refresh_token) { should be_nil }
  end

  context "refresh token" do
    let(:refresh_token) { FactoryGirl.create :refresh_token, user: user, client: client }
    before { oauth.refresh_token = refresh_token.token }
    subject { oauth.access_token! }
    let(:access_token) { refresh_token.access_tokens.last }

    its(:access_token) { should == access_token.token }
    its(:refresh_token) { should be_nil }
  end

  context "password" do
    before { oauth.resource_owner_credentials = user.email, user.password }
    subject { oauth.access_token! }
    let(:user_token) { user.access_tokens.last }

    its(:access_token) { should == user_token.token }
    its(:refresh_token) { should == user_token.refresh_token.token }
  end
end
