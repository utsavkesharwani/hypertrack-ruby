require "json"
require_relative "util"
require_relative "hypertrack/api_client"
require_relative "hypertrack/shared_resource"
require_relative "hypertrack/driver"
require_relative "hypertrack/customer"
require_relative "hypertrack/destination"
require_relative "hypertrack/task"

class HyperTrackApi

  attr_accessor :secret_key, :driver, :customer, :destination, :task

  def initialize(options)
    options      = Util.symbolize_keys(options)
    @secret_key  = options[:secret_key]
    @driver      = HyperTrack::Driver.new(@secret_key)
    @customer    = HyperTrack::Customer.new(@secret_key)
    @destination = HyperTrack::Destination.new(@secret_key)
    @task        = HyperTrack::Task.new(@secret_key)
  end

end