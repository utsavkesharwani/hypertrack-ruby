module HyperTrack
  module ApiOperations
    module Common
      module ParamsValidator

        def valid_args?(params, required_fields, valid_attr_values)
          unless valid_params_object?(params)
            raise "Error: Expected a Hash. Got: #{params}"
          end

          params = Util.symbolize_keys(params)

          if missing_required_fields?(params, required_fields)
            raise "Request is missing required params - #{required_fields - params.keys}"
          end

          params.each do |name, value|
            next if Util.blank?(value) && valid_attr_values[name][:allow_nil]

            valid_values = valid_attr_values[name][:allowed]
            next if valid_values.nil?

            if !valid_values.include?(value) && !valid_values.include?(value.to_sym)
              raise "Error: Invalid #{name}: #{value}. Allowed: #{valid_values.join(', ')}"
            end
          end

          true
        end

        private

        def valid_params_object?(params)
          params.is_a?(Hash)
        end

        def missing_required_fields?(params, required_fields)
          required_fields.each do |field|
            return true if Util.blank?(params[field])
          end

          false
        end

      end
    end
  end
end