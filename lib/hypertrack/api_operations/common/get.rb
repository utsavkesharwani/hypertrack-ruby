module HyperTrack
  module ApiOperations
    module Common
      module Get

        def get(path, params, required_params=[])
          if HyperTrack::ParamsValidator.valid_args?(params, required_params, self.class::VALID_ATTRIBUTE_VALUES)
            api_path = "#{self.class::API_BASE_PATH}#{self.id}/" + path
            result = HyperTrack::ApiClient.fetch(api_path, params)
          end
        end

      end
    end
  end
end
