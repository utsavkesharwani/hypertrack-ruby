module HyperTrack
  module ApiOperations
    module Common
      module List

        def list(filter_params={})
          api_result = HyperTrack::ApiClient.fetch(get_class_name::API_BASE_PATH, filter_params)

          api_result['results'].each_with_index do |opts, idx|
            api_result['results'][idx] = get_class_name.new(opts['id'], opts)
          end

          api_result
        end

      end
    end
  end
end