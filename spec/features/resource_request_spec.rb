require 'spec_helper'
require 'rack/oauth2'

# TODO: add controller specs to accompany this
describe "Resource request" do
  let(:bearer_token) { Rack::OAuth2::AccessToken::Bearer.new(:access_token => access_token.token) }
  let(:server) { Capybara::Server.new(Capybara.app).boot }
  let(:base_url) { "http://#{server.host}:#{server.port}/" }

  def get(path)
    bearer_token.get base_url + path
  end

  context "for client" do
    let(:access_token) { FactoryGirl.create :access_token }
    subject { get "protected_client" }
    its(:body) { should == 'protected client!' }
  end

  context "for user" do
    let(:access_token) { FactoryGirl.create :user_access_token }
    subject { get "protected_user" }
    its(:body) { should == 'protected user!' }
  end
end
