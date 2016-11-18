# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'camel_patrol/version'

Gem::Specification.new do |spec|
  spec.name          = "camel_patrol"
  spec.version       = CamelPatrol::VERSION
  spec.authors       = ["Bernardo Farah"]
  spec.email         = ["bernardo@coverhound.com"]

  spec.summary       = "Middleware to transform camelCase into snake_case and back"
  spec.description   = "Middleware to transform camelCase into snake_case and back"
  spec.homepage      = "https://github.com/coverhound/camel_patrol"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 4.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
