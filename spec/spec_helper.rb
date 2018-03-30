require 'webmock/rspec'
require 'simplecov'
require 'active_support'
require 'active_support/core_ext'

SimpleCov.start do
  add_filter %r{^/spec/}
end

Dir[File.join(File.expand_path(Dir.pwd), 'lib/**/', '*.rb')].each { |file| require_relative file }

ENV['QUANDL_API_KEY'] = 'valid_api_key'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec::Expectations.configuration.on_potential_false_positives = :nothing
