require "json"
require 'net/https'

require_relative "util"

require_relative "hypertrack/api_operations/create"
require_relative "hypertrack/api_operations/retrieve"
require_relative "hypertrack/api_operations/list"

require_relative "hypertrack/api_client"

require_relative "hypertrack/shared_resource"
require_relative "hypertrack/driver"
require_relative "hypertrack/customer"
require_relative "hypertrack/destination"
require_relative "hypertrack/task"

module HyperTrack

  class << self
    attr_accessor :secret_key
  end

end