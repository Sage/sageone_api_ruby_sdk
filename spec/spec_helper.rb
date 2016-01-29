require "sageone_sdk"
require 'webmock/rspec'
require 'simplecov'
require 'vcr'

SimpleCov.start

VCR.configure do |c|
  c.configure_rspec_metadata!

  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock

  c.default_cassette_options = {
    :serialize_with             => :json
  }

  c.filter_sensitive_data("<ACCESS_TOKEN>") do |interaction|
    "dummy_access_token"
  end

  c.filter_sensitive_data("<SIGNING_SECRET>") do |interaction|
    "dummy_signing_secret"
  end
end

SageoneSdk.configure do |config|
  config.access_token = "dummy_access_token"
  config.signing_secret = "dummy_signing_secret"
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
