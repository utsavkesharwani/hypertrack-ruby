module HyperTrack
  module ApiOperations
    module TripAPI

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods

        def sending_eta(params)
          if HyperTrack::ParamsValidator.valid_args?(params, [:driver, :destination], HyperTrack::Trip::VALID_ATTRIBUTE_VALUES)
            eta_path = "#{HyperTrack::Trip::API_BASE_PATH}lite/"
            HyperTrack::ApiClient.update(eta_path, params)
          end
        end

      end

      # Don't want to name this method as 'end'. Its a reserved keyword in Ruby.
      def end_trip(params)
        path = "end/"
        self.update(path, params, [])
      end

      def add_task(params)
        path = 'add_task/'
        self.update(path, params, [:task_id])
      end

      def remove_task(params)
        path = 'remove_task/'
        self.update(path, params, [:task_id])
      end

      def change_task_order(params)
        path = 'change_task_order/'
        self.update(path, params, [:task_order])
      end

    end
  end
end