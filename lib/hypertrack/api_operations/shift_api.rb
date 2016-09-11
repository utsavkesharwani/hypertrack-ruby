module HyperTrack
  module ApiOperations
    module ShiftAPI

      # Don't want to name this method as 'end'. Its a reserved keyword in Ruby.
      def end_shift(params)
        path = "end/"
        self.update(path, params, [:end_location])
      end

    end
  end
end