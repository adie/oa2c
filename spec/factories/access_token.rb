FactoryGirl.define do
  factory :access_token, class: 'Oa2c::AccessToken' do
    client

    factory :user_access_token do
      user
    end
  end
end
