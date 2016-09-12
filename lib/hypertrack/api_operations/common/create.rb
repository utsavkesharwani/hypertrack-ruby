module HyperTrack
  module ApiOperations
    module Common
      module Create

        def create(params={})
          if HyperTrack::ParamsValidator.valid_args?(params, get_class_name::REQUIRED_FIELDS, get_class_name::VALID_ATTRIBUTE_VALUES)
            result = HyperTrack::ApiClient.create(get_class_name::API_BASE_PATH, params)
            get_class_name.new(result['id'], result)
          end
        end

      end
    end
  end
end