FactoryGirl.define do
  factory :refresh_token, class: 'Oa2c::RefreshToken' do
    user
    client
  end
end
