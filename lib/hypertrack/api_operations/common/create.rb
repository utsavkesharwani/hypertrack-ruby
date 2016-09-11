module HyperTrack
  module ApiOperations
    module Common
      module Create
        extend HyperTrack::ApiOperations::Common::ParamsValidator

        def self.included(base)
          base.send :extend, HyperTrack::ApiOperations::Common::ParamsValidator
        end

        def create(params={})
          if valid_args?(params, get_class_name::REQUIRED_FIELDS, get_class_name::VALID_ATTRIBUTE_VALUES)
            result = HyperTrack::ApiClient.create(get_class_name::API_BASE_PATH, params)
            get_class_name.new(result['id'], result)
          end
        end

      end
    end
  end
end