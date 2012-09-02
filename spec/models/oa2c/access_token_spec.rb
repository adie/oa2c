require 'spec_helper'

module Oa2c
  describe AccessToken do
    it { should be_a OAuth2Token }

    describe "#to_bearer_token" do
      subject { AccessToken.new token: "token", expires_at: 3.days.from_now }

      it "should return proper Bearer token" do
        subject.to_bearer_token.should be_a Rack::OAuth2::AccessToken::Bearer
      end
    end
  end
end
