module HyperTrack
  module ParamsValidator

    class << self

      def valid_args?(params, required_fields, valid_attr_values)
        unless valid_params_object?(params)
          raise HyperTrack::InvalidParameters.new("Error: Expected a Hash. Got: #{params}")
        end

        params = Util.symbolize_keys(params)

        missing_params = missing_required_fields(params, required_fields)
        if missing_params.length > 0
          raise HyperTrack::InvalidParameters.new("Request is missing required params - #{missing_params}")
        end

        params.each do |name, value|
          next if Util.blank?(value) && valid_attr_values[name][:allow_nil]
          next if valid_attr_values[name].nil? || valid_attr_values[name][:allowed].nil?

          valid_values = valid_attr_values[name][:allowed]
          if !valid_values.include?(value) && !valid_values.include?(value.to_sym)
            raise HyperTrack::InvalidParameters.new("Error: Invalid #{name}: #{value}. Allowed: #{valid_values.join(', ')}")
          end
        end

        true
      end

      private

      def valid_params_object?(params)
        params.is_a?(Hash)
      end

      def missing_required_fields(params, required_fields)
        missing_fields = []
        required_fields.each do |field|
          missing_fields << field if Util.blank?(params[field])
        end

        missing_fields
      end

    end
  end
end