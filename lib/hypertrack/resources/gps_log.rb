module HyperTrack
  class GPSLog < HyperTrack::SharedResource
    include HyperTrack::ApiOperations::GPSLogAPI

    API_BASE_PATH = "gps/"
    REQUIRED_FIELDS = [:driver_id, :location, :speed, :bearing, :altitude, :recorded_at]

    VALID_ATTRIBUTE_VALUES = {
      activities: {
        allowed: [:stationary, :walking, :running, :automotive, :cycling, :unknown]
      },
      activity_confidence: {
        allowed: (0..100).to_a
      }
    }

    def self.create(params={})
      raise HyperTrack::MethodNotAllowed.new("Create not allowed on HyperTrack::GPSLog class")
    end

    def self.list(params={})

      if params.is_a?(Hash)
        params[:filtered] ? params.delete(:raw) : params[:raw] = true
      end

      super(params)
    end

  end
end
