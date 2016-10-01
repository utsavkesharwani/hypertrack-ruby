module HyperTrack
  module ApiOperations
    module TaskAPI

      def editable_url(params)
        if HyperTrack::ParamsValidator.valid_args?(params, [:editable], self.class::VALID_ATTRIBUTE_VALUES)
          api_path = "#{self.class::API_BASE_PATH}#{self.id}/editable_url/"
          HyperTrack::ApiClient.update(api_path, params)
        end
      end

      def start(params)
        path = "start/"
        self.update(path, params, [:start_location, :start_time])
      end

      def complete(params)
        path = "completed/"
        self.update(path, params, [:completion_location])
      end

      def cancel(params={})
        path = "canceled/"
        self.update(path, params)
      end

      def update_destination(params)
        path = "update_destination/"
        self.update(path, params, [:location])
      end

    end
  end
end