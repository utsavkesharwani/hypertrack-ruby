require "json"
require "net/https"

require_relative "util"
require_relative "hypertrack/params_validator"

# Errors
require_relative "hypertrack/errors/hypertrack_errors"

# API Operations
require_relative "hypertrack/api_operations/common/create"
require_relative "hypertrack/api_operations/common/get"
require_relative "hypertrack/api_operations/common/nearby"
require_relative "hypertrack/api_operations/common/retrieve"
require_relative "hypertrack/api_operations/common/list"
require_relative "hypertrack/api_operations/common/update"
require_relative "hypertrack/api_operations/user_api"
require_relative "hypertrack/api_operations/action_api"

# All HTTP calls made here
require_relative "hypertrack/api_client"

# HyperTrack Resouce Wrapper
require_relative "hypertrack/shared_resource"

# Resources
require_relative "hypertrack/resources/user"
require_relative "hypertrack/resources/action"

module HyperTrack

  class << self
    attr_accessor :secret_key
  end

end