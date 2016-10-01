require "rspec"
require "webmock/rspec"

RSpec.configure do |c|
  c.before :each do
    WebMock.disable_net_connect!(allow_localhost: true)
  end
end
