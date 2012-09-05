FactoryGirl.define do
  factory :client, class: 'Oa2c::Client' do
    redirect_uri 'http://example.com/callback'
  end
end
