require 'finicity'
require 'pry'

::Finicity.configure do |config|
  config.base_url = "https://api.finicity.com/aggregation/"
end

# set up simplecov
require 'simplecov'

::SimpleCov.start do
  add_filter 'spec/'
end

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|

  # Enable should syntax
  config.expect_with :rspec do |rspec|
    rspec.syntax = [ :should, :expect ]
  end

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  # silence the logger
  config.before(:suite) { ::Finicity.logger.level = ::Logger::FATAL }
end
