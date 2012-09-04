require 'spec_helper'

module Oa2c
  class Token
    include Mongoid::Document
    include OAuth2Token
  end

  describe OAuth2Token do
    subject { Token }

    its(:default_lifetime) { should == 15.minutes }

    context "on create" do
      subject { Token.new }
      it "should generate token" do
        subject.token.should be_blank
        subject.save
        subject.token.should_not be_blank
      end

      it "should set expiring date to default lifetime" do
        Timecop.freeze do
          subject.expires_at.should be_blank
          subject.save
          subject.expires_at.should == 15.minutes.from_now
        end
      end
    end
  end
end
