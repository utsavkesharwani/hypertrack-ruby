module HyperTrack
  module ApiOperations
    module Common
      module Nearby

        def nearby(params, required_params=[:action_id])
          if HyperTrack::ParamsValidator.valid_args?(params, required_params, get_class_name::VALID_ATTRIBUTE_VALUES)
            api_path = "#{get_class_name::API_BASE_PATH}" + "nearby/"
            response = HyperTrack::ApiClient.fetch(api_path, params)
            result = []

            response["results"].each do |user|
              result.push(get_class_name.new(user['id'], user))
            end

            result
          end
        end

      end
    end
  end
end
