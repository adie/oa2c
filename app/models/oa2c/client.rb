module Oa2c
  class Client
    include Mongoid::Document

    field :identifier
    field :secret
    field :redirect_uri
    field :name

    has_many :access_tokens, class_name: "Oa2c::AccessToken"
    has_many :refresh_tokens, class_name: "Oa2c::RefreshToken"

    before_validation :setup, on: :create
    validates :secret, presence: true
    validates :identifier, presence: true, uniqueness: true

    private

    def setup
      self.identifier = SecureRandom.hex(16)
      generate_secret
    end

    def generate_secret
      self.secret = SecureRandom.hex(32)
    end

    def generate_secret!
      generate_secret
      save!
    end
  end
end
