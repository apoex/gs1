require 'bundler/setup'

require 'byebug'
require 'simplecov'

require 'support/normalization_helper'

require 'support/define_check_digit_matcher'
require 'support/define_date_matcher'
require 'support/define_length_matcher'
require 'support/shared_gs1_extensions'

SimpleCov.start

require 'gs1'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random

  Kernel.srand config.seed
end
