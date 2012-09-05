FactoryGirl.define do
  factory :authorization_code, class: 'Oa2c::AuthorizationCode' do
    user
    client
    redirect_uri {|c| c.client.redirect_uri }
  end
end
