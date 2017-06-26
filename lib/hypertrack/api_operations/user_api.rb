module HyperTrack
  module ApiOperations
    module UserAPI

      def assign_actions(params)
        path = "assign_actions/"
        self.update(path, params, [:action_ids])
      end

      def nearby(params)
        path = "nearby/"
        self.retrieve(path, params, [:action_id])
      end

    end
  end
end