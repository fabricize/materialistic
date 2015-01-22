$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'materialistic'

require 'webmock/rspec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  # config.allow_http_connections_when_no_cassette = true
end
