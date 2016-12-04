require "rspec"
require "webmock/rspec"
require 'simplecov'
SimpleCov.start

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov

RSpec.configure do |c|
  c.before :each do
    WebMock.disable_net_connect!(allow_localhost: true)
  end
end
