# Oa2c - OAuth2 Container

Rails OAuth2 provider engine to support embedded iframe applications from different sites. Just like games on Facebook.

Heavily depends on [rack-oauth2](https://github.com/nov/rack-oauth2) gem.

It's mostly extract from [rack-oauth2-sample](https://github.com/nov/rack-oauth2-sample).

Right now it supports only Mongoid 3 as ORM.

# Configuration

To change some settings, e.g. user model, add an initializer `config/initializers/oa2c.rb`:

```ruby
Oa2c.setup do |config|
  config.user_model = "User"
end
```

# User model

You need to add this line to your user model:

```ruby
  include Oa2c::User
```

This will add `access_tokens` and `authorization_codes` associations.

# TODO

* Write specs
* Support for ActiveRecord

# License

See MIT-LICENSE

# Contribute

Pull requests are more than welcome!
