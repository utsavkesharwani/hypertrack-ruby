module HyperTrack
  class Shift < HyperTrack::SharedResource
    include HyperTrack::ApiOperations::ShiftAPI

    API_BASE_PATH = "shifts/"
    REQUIRED_FIELDS = [:driver_id, :start_location]

    VALID_ATTRIBUTE_VALUES = {}

  end
end
