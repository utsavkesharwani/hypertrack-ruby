module HyperTrack
  module ApiOperations
    module Retrieve

      def retrieve(id)
        raise "ID is required to retrieve a #{self.name}" unless valid_retrieve_id?(id)

        retrieve_customer_path = "#{get_class_name::API_BASE_PATH}#{id}/"
        result = HyperTrack::ApiClient.fetch(retrieve_customer_path)

        get_class_name.new(id, result)
      end

      private

      def valid_retrieve_id?(id)
        !Util.blank?(id)
      end

    end
  end
end