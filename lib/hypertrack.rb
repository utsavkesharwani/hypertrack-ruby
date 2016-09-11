require "json"
require 'net/https'

require_relative "util"

require_relative "hypertrack/api_operations/common/create"
require_relative "hypertrack/api_operations/common/retrieve"
require_relative "hypertrack/api_operations/common/list"
require_relative "hypertrack/api_operations/common/update"
require_relative "hypertrack/api_operations/driver_api"
require_relative "hypertrack/api_operations/task_api"

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