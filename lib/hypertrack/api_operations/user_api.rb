module HyperTrack
  module ApiOperations
    module UserAPI

      def assign_actions(params)
        path = "assign_actions/"
        self.update(path, params, [:action_ids])
      end

    end
  end
end