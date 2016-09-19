module HyperTrack
  class GPSLog < HyperTrack::SharedResource

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

    class << self

      def filtered_logs(params)
        path = "#{API_BASE_PATH}filtered/"
        if HyperTrack::ParamsValidator.valid_args?(params, [:driver_id], get_class_name::VALID_ATTRIBUTE_VALUES)
          result = HyperTrack::ApiClient.fetch(path, params)
          # get_class_name.new(result['id'], result)
        end
      end

    end

  end
end
