module HyperTrack
  module ApiOperations
    module DriverAPI

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods

        def map_list(filter_params={})
          map_list_path = "#{HyperTrack::Driver::API_BASE_PATH}map_list/"
          HyperTrack::ApiClient.fetch(map_list_path, filter_params)
        end

      end

      def overview(filter_params={})
        driver_overview_path = "#{HyperTrack::Driver::API_BASE_PATH}#{self.id}/overview/"
        HyperTrack::ApiClient.fetch(driver_overview_path, filter_params)
      end

    end
  end
end