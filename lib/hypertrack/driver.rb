module HyperTrack
  class Driver < HyperTrack::SharedResource
    include HyperTrack::ApiOperations::DriverAPI

    API_BASE_PATH = "drivers/"
    REQUIRED_FIELDS = [:name, :vehicle_type]

    class << self
      def create(params)
        # To-Do: Add a common validator, like before_filter in Rails
        raise "Error: Expected a Hash. Got: #{params}" unless valid_create_params?(params)

        params = Util.symbolize_keys(params)

        raise "Error: Invalid vehicle_type: #{params[:vehicle_type]}. Allowed: #{HyperTrack::SharedResource::VALID_VEHICLE_TYPES.join(', ')}" unless valid_vehicle_type?(params[:vehicle_type])

        super
      end
    end

  end
end
