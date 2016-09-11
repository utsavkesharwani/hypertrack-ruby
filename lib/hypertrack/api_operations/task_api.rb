module HyperTrack
  module ApiOperations
    module TaskAPI

      def editable_url(params)
        path = "editable_url/"
        self.update(path, params, [:editable])
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

      private

      def valid_editable_url?(value)
        HyperTrack::Task::VALID_EDITABLE_VALUES.include?(value.to_sym)
      end

    end
  end
end