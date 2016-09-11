module HyperTrack
  class Trip < HyperTrack::SharedResource
    include HyperTrack::ApiOperations::TripAPI

    API_BASE_PATH = "trips/"
    REQUIRED_FIELDS = [:driver_id, :start_location, :tasks]

    VALID_ATTRIBUTE_VALUES = {
      vehicle_type: {
        allowed: HyperTrack::SharedResource::VALID_VEHICLE_TYPES
      }
    }

  end
end
