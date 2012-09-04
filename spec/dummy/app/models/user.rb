class User
  include Mongoid::Document

  devise :database_authenticatable

  field :email
  field :encrypted_password

  include Oa2c::User
end
