# frozen_string_literal: true

require "dotenv"
require "vercellus"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    Dotenv.load(File.expand_path("../.env.test.local", __dir__))

    Vercellus.configure do |config|
      config.token = ENV["VERCELLUS_TOKEN"] || "vercellus_test_token"
    end
  end
end
