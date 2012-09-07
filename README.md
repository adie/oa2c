# Oa2c - OAuth2 Container

[![Build Status](https://secure.travis-ci.org/adie/oa2c.png)](http://travis-ci.org/adie/oa2c)

Rails OAuth2 provider engine to support embedded iframe applications from different sites. Just like games on Facebook.

Heavily depends on [rack-oauth2](https://github.com/nov/rack-oauth2) gem.

It's mostly extract from [rack-oauth2-sample](https://github.com/nov/rack-oauth2-sample).

Right now it supports only Mongoid 3 as ORM.

# Configuration

To change some settings, e.g. user model, add an initializer `config/initializers/oa2c.rb`:

```ruby
Oa2c.setup do |config|
  config.user_model = "User"
  config.authentication_method = :authenticate_user!
  config.login_method = :sign_in
  config.current_user_method = :current_user
  config.find_for_user_password_authentication = proc {|username, password|
    user = Oa2c.user_model.constantize.where(email: username).first
    user if user.valid_password? password
  }
end
```

**Note**: these are defaults for Devise. You don't need to do anything if you use the same settings

# User model

You need to add this line to your user model:

```ruby
  include Oa2c::User
```

This will add `access_tokens` and `authorization_codes` associations.

# License

See MIT-LICENSE

# Contribute

Pull requests are more than welcome!
