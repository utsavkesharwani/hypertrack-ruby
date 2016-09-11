module HyperTrack
  class Task < HyperTrack::SharedResource
    include HyperTrack::ApiOperations::TaskAPI

    API_BASE_PATH = "tasks/"
    REQUIRED_FIELDS = []

    VALID_ATTRIBUTE_VALUES = {
      action: {
        allowed: [:pickup, :delivery, :visit, :task],
        allow_nil: true
      },
      editable: {
        allowed: [:'not editable', :once, :multiple]
      },
      vehicle_type: {
        allowed: HyperTrack::SharedResource::VALID_VEHICLE_TYPES
      }
    }

  end
end
