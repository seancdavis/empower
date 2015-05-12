$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "empower/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "empower"
  spec.version     = Empower::VERSION
  spec.authors     = ["Sean C Davis"]
  spec.email       = ["scdavis41@gmail.com"]
  spec.homepage    = "https://github.com/seancdavis/empower"
  spec.summary     = ""
  spec.description = ""
  spec.license     = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 4.1.0"
  spec.add_dependency "devise"
  spec.add_dependency 'omniauth'
  spec.add_dependency 'omniauth-facebook'
  spec.add_dependency 'omniauth-google-oauth2'

  spec.add_development_dependency "bundler", "~> 1.6"
end
