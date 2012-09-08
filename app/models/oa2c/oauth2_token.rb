module Oa2c
  module OAuth2Token
    extend ActiveSupport::Concern

    included do
      cattr_accessor :default_lifetime
      self.default_lifetime = 15.minutes

      field :token
      field :expires_at, type: Time

      belongs_to :user, class_name: Oa2c.user_model
      belongs_to :client, class_name: "Oa2c::Client"

      before_validation :setup, on: :create
      validates :client, :expires_at, presence: true
      validates :token, presence: true, uniqueness: true

      scope :valid, proc { where(:expires_at.gte => Time.now) }
    end

    def expires_in
      (expires_at - Time.now).to_i
    end

    def expire!
      update_attributes! expires_at: Time.now
    end

    private

    def setup
      self.token = SecureRandom.hex(32)
      self.expires_at ||= default_lifetime.from_now
    end
  end
end


