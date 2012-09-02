require 'spec_helper'

module Oa2c
  describe Client do
    it "should generate id and secret on create" do
      client = Client.new
      client.identifier.should be_blank
      client.secret.should be_blank
      client.save
      client.identifier.should_not be_blank
      client.secret.should_not be_blank
    end
  end
end
