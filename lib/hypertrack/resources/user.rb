module HyperTrack
  class User < HyperTrack::SharedResource
    include HyperTrack::ApiOperations::UserAPI

    API_BASE_PATH = "users/"
    REQUIRED_FIELDS = [:name]

    VALID_ATTRIBUTE_VALUES = {
      vehicle_type: {
        allowed: HyperTrack::SharedResource::VALID_VEHICLE_TYPES
      }
    }

  end
end
