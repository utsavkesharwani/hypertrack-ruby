module HyperTrack
  module ApiOperations
    module Common
      module Update
        include HyperTrack::ApiOperations::Common::ParamsValidator

        def update(path, params, required_params=[])
          if valid_args?(params, required_params, self.class::VALID_ATTRIBUTE_VALUES)
            api_path = "#{self.class::API_BASE_PATH}#{self.id}/" + path
            result = HyperTrack::ApiClient.update(api_path, params)
            update_attributes_in_object(result)
          end
        end

        private

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