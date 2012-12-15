$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "oa2c/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "oa2c"
  s.version     = Oa2c::VERSION
  s.authors     = ["Anton Dieterle"]
  s.email       = ["antondie@gmail.com"]
  s.homepage    = "https://github.com/adie/oa2c"
  s.summary     = "OAuth2 authorization for embedded iframe applications."
  s.description = "Rails engine to provide OAuth2 authorization for embedded iframe applications."

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_dependency "rails", "~> 3.2.0"
  s.add_dependency "rack-oauth2", "~> 1.0.0"
  s.add_dependency "mongoid", "~> 3.0"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "capybara"
  s.add_development_dependency "timecop"
  s.add_development_dependency "devise"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "database_cleaner"
end
