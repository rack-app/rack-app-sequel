require "bundler/setup"
require "rack/app/sequel"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
