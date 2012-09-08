# Oa2c - OAuth2 Container

[![Build Status](https://secure.travis-ci.org/adie/oa2c.png)](http://travis-ci.org/adie/oa2c)

Rails OAuth2 provider engine to support embedded iframe applications from different sites. Just like games on Facebook.

Heavily depends on [rack-oauth2](https://github.com/nov/rack-oauth2) gem.

It's mostly extract from [rack-oauth2-sample](https://github.com/nov/rack-oauth2-sample).

Right now it supports only Mongoid 3 as ORM.

# Installation

First of all, add `gem 'oa2c'` to your Gemfile and bundle it.

Then add this to `config/application.rb`:

```ruby
  config.middleware.use Oa2c::Middleware
```

And add this to your `config/routes.rb`:

```ruby
  mount Oa2c::Engine => "/oauth"
```

And then you need to add this line to your user model:

```ruby
  include Oa2c::User
```

This will add `access_tokens` and `authorization_codes` associations.

And finally add to your controllers that require OAuth2 authentictation:

```ruby
  include Oa2c::Authentication
```

# Configuration

To change some settings, e.g. user model, add an initializer `config/initializers/oa2c.rb`:

```ruby
Oa2c.setup do |config|
  config.user_model = "User"
  config.authentication_method = :authenticate_user!
  config.login_method = :sign_in
  config.current_user_method = :current_user
  config.find_user_for_password_authentication = proc {|username, password|
    user = Oa2c.user_model.constantize.where(email: username).first
    user if user.valid_password? password
  }
  config.auto_approve = false # if true, don't show 'approve' / 'deny' buttons to user
  config.layout = false # flase or symbol, just like in controllers
end
```

**Note**: these are defaults for Devise. You don't need to do anything if you use the same settings

# License

See MIT-LICENSE

# Contribute

Pull requests are more than welcome!
