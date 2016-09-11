module HyperTrack
  class Driver < HyperTrack::SharedResource
    include HyperTrack::ApiOperations::DriverAPI

    API_BASE_PATH = "drivers/"
    REQUIRED_FIELDS = [:name, :vehicle_type]

    VALID_ATTRIBUTE_VALUES = {
      vehicle_type: {
        allowed: HyperTrack::SharedResource::VALID_VEHICLE_TYPES
      }
    }

  end
end
