module HyperTrack
  module ApiOperations
    module ActionAPI

      def complete(params={})
        path = "complete/"
        self.update(path, params, [:completion_location])
      end

      def cancel(params={})
        path = "cancel/"
        self.update(path, params)
      end

    end
  end
end