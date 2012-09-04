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

  let(:user) { FactoryGirl.create :user }

  context "token request" do
    before do
      sign_in user
      visit conn.authorization_uri(response_type: :token)
    end

    it "should show approve/deny buttons" do
      page.should have_button "Approve"
      page.should have_button "Deny"
    end

    context "when user clicks on approve" do
      before { page.click_on "Approve" }

      it "should redirect to callback url" do
        page.current_url.should == client.redirect_uri
      end
    end
  end

  context "code request" do
    before { visit conn.authorization_uri }
    it { page.status_code.should == 200 }
  end
end
