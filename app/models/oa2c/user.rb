module Oa2c
  module User
    extend ActiveSupport::Concern
    included do
      has_many :access_tokens, class_name: "Oa2c::AccessToken"
      has_many :authorization_codes, class_name: "Oa2c::AuthorizationCode"
    end
  end
end
