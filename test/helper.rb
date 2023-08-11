require_relative "../lib/ya_finance.rb"
require 'test/unit'
require 'webmock'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures/vcr_cassettes"
  config.hook_into :webmock
  # config.debug_logger = File.open("playback.log", 'w')
  config.default_cassette_options = {
    serialize_with: :json
  }
end

