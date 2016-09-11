module HyperTrack
  module ApiOperations
    module Common
      module Update

        def update(api_path, params, required_params=[])
          raise "Error: Expected a Hash. Got: #{params}" unless valid_update_params?(params)

          params = Util.symbolize_keys(params)

          raise "Request is missing required params - #{required_params - params.keys}" if missing_required_fields?(params, required_params)

          result = HyperTrack::ApiClient.update(api_path, params)

          update_attributes_in_object(result)
        end

        private

        def valid_update_params?(params)
          params.is_a?(Hash)
        end

        def missing_required_fields?(params, required_params)
          required_params.each do |field|
            return true if Util.blank?(params[field])
          end

          false
        end

        def update_attributes_in_object(result)
          result = Util.symbolize_keys(result)

          self_keys = self.keys

          result.each do |key, value|
            if self_keys.include?(key) && self[key] != value
              self[key] = value
            end
          end

          self
        end

      end
    end
  end
end