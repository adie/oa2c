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

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.0"
  s.add_dependency "rack-oauth2", "~> 0.14.9"
  s.add_dependency "mongoid", "~> 3.0"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3"
end
