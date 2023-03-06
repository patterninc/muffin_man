# frozen_string_literal: true

require "muffin_man"
require "webmock/rspec"
require "support/sp_api_helpers"
require "support/lwa_helpers"
require "byebug"

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.include Support::SpApiHelpers
  config.include Support::LwaHelpers
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
