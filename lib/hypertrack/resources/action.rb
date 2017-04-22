module HyperTrack
  class Action < HyperTrack::SharedResource
    include HyperTrack::ApiOperations::ActionAPI

    API_BASE_PATH = "actions/"
    REQUIRED_FIELDS = []

    VALID_ATTRIBUTE_VALUES = {
      type: {
        allowed: [:pickup, :delivery, :dropoff, :visit, :stoppver, :task],
        allow_nil: true
      },
      vehicle_type: {
        allowed: HyperTrack::SharedResource::VALID_VEHICLE_TYPES,
        allow_nil: true
      }
    }

  end
end
