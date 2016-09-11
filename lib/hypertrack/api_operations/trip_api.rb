module HyperTrack
  module ApiOperations
    module TripAPI

      # Don't want to name this method as 'end'. Its a reserved keyword in Ruby.
      def end_trip(params)
        path = "end/"
        self.update(path, params, [:end_location])
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