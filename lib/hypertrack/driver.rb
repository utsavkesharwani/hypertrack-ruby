module HyperTrack

  class Driver < HyperTrack::ApiClient

    API_END_POINT = "#{API_BASE_URL}/#{API_VERSION}/drivers/"

    attr_accessor :name, :vehicle_type, :photo, :phone, :is_sendeta, :lookup_id, :fleet_id

    class << self

      def create(params)
        result = super(API_END_POINT, params)
      end

    end

  end
end