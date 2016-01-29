# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sageone_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = "sageone_sdk"
  spec.version       = SageoneSdk::VERSION
  spec.authors       = ["Sage UK Ltd"]
  spec.email         = ["support@sageone.com"]
  spec.summary       = "SDK for Sage One API."
  spec.description   = "Provides Ruby methods for accessing the Sage One API endpoints."
  spec.homepage      = "https://developers.sageone.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'sawyer', '~> 0.5.3'
  spec.add_dependency 'faraday_middleware', "~> 0.9.1"
  spec.add_dependency 'hashie'
  spec.add_dependency 'yard'
  spec.add_dependency "activesupport", "~> 4.0.4"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency 'cane'
  spec.add_development_dependency 'flay'
  spec.add_development_dependency 'flog'
  spec.add_development_dependency 'fudge'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'yard'
end
