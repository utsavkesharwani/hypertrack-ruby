require "json"
require 'net/https'

require_relative "util"

# API Operations
require_relative "hypertrack/api_operations/common/params_validator"
require_relative "hypertrack/api_operations/common/create"
require_relative "hypertrack/api_operations/common/retrieve"
require_relative "hypertrack/api_operations/common/list"
require_relative "hypertrack/api_operations/common/update"
require_relative "hypertrack/api_operations/driver_api"
require_relative "hypertrack/api_operations/task_api"
require_relative "hypertrack/api_operations/trip_api"
require_relative "hypertrack/api_operations/shift_api"

# All HTTP calls made here
require_relative "hypertrack/api_client"

# HyperTrack Resouce Wrapper
require_relative "hypertrack/shared_resource"

# Resources
require_relative "hypertrack/resources/driver"
require_relative "hypertrack/resources/customer"
require_relative "hypertrack/resources/destination"
require_relative "hypertrack/resources/task"
require_relative "hypertrack/resources/trip"
require_relative "hypertrack/resources/neighbourhood"
require_relative "hypertrack/resources/fleet"
require_relative "hypertrack/resources/hub"
require_relative "hypertrack/resources/shift"
require_relative "hypertrack/resources/event"

module HyperTrack

  class << self
    attr_accessor :secret_key
  end

end