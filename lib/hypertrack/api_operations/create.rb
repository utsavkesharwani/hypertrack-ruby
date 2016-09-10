module HyperTrack
  module ApiOperations
    module Create

      def create(params)
        raise "Error: Expected a Hash. Got: #{params}" unless valid_create_params?(params)

        params = Util.symbolize_keys(params)

        raise "Request is missing required params - #{get_class_name::REQUIRED_FIELDS - params.keys}" if missing_required_fields?(params)

        result = HyperTrack::ApiClient.create(get_class_name::API_BASE_PATH, params)

        get_class_name.new(result['id'], result)
      end

      private

      def valid_create_params?(params)
        params.is_a?(Hash)
      end

      def missing_required_fields?(params)
        get_class_name::REQUIRED_FIELDS.each do |field|
          return true if Util.blank?(params[field])
        end

        false
      end

    end
  end
end