module HyperTrack
  module ApiOperations
    module GPSLogAPI

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods

        def filtered_list(params)
          if HyperTrack::ParamsValidator.valid_args?(params, [:driver_id], HyperTrack::GPSLog::VALID_ATTRIBUTE_VALUES)
            HyperTrack::GPSLog.list(params.merge(filtered: true))
          end
        end

      end
    end
  end
end