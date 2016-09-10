module HyperTrack
  module ApiOperations
    module TaskAPI

      def editable_url(editable_url_value)
        raise "Error: Invalid editable_url: #{editable_url_value}. Allowed: #{HyperTrack::Task::VALID_EDITABLE_VALUES.join(', ')}" unless valid_editable_url?(editable_url_value)

        update_editable_url_path = "#{HyperTrack::Task::API_BASE_PATH}#{self.id}/editable_url/"
        result = Util.symbolize_keys(HyperTrack::ApiClient.update(update_editable_url_path, { editable: editable_url_value }))

        puts result

        update_attributes_in_object(result)
      end

      def start(params)
        raise "Error: Expected a Hash. Got: #{params}" unless params.is_a?(Hash)

        params = Util.symbolize_keys(params)

        raise "Error: Invalid start_location: '#{params[:start_location]}'." unless valid_start_location?(params[:start_location])
        raise "Error: Invalid start_time: '#{params[:start_time]}'." unless valid_start_time?(params[:start_time])
        # To-Do: Add validation for valid vehicle type

        start_task_path = "#{HyperTrack::Task::API_BASE_PATH}#{self.id}/start/"
        result = Util.symbolize_keys(HyperTrack::ApiClient.update(start_task_path, params))

        update_attributes_in_object(result)
      end

      def complete(params)
        raise "Error: Expected a Hash. Got: #{params}" unless params.is_a?(Hash)

        params = Util.symbolize_keys(params)

        raise "Error: Invalid completion_location: '#{params[:completion_location]}'." unless valid_completion_location?(params[:completion_location])

        complete_task_path = "#{HyperTrack::Task::API_BASE_PATH}#{self.id}/completed/"
        result = Util.symbolize_keys(HyperTrack::ApiClient.update(complete_task_path, params))

        update_attributes_in_object(result)
      end

      def cancel(params={})
        raise "Error: Expected a Hash. Got: #{params}" unless params.is_a?(Hash)

        params = Util.symbolize_keys(params)

        cancel_task_path = "#{HyperTrack::Task::API_BASE_PATH}#{self.id}/canceled/"
        result = Util.symbolize_keys(HyperTrack::ApiClient.update(cancel_task_path, params))

        update_attributes_in_object(result)
      end

      def update_destination(params)
        raise "Error: Expected a Hash. Got: #{params}" unless params.is_a?(Hash)

        params = Util.symbolize_keys(params)

        raise "Error: Invalid location: '#{params[:location]}'." unless valid_location?(params[:location])

        update_task_destination_path = "#{HyperTrack::Task::API_BASE_PATH}#{self.id}/update_destination/"
        result = Util.symbolize_keys(HyperTrack::ApiClient.update(update_task_destination_path, params))

        update_attributes_in_object(result)
      end

      private

      def required_update_attribute_present?(value)
        !Util.blank?(value)
      end
      alias_method :valid_start_location?, :required_update_attribute_present?
      alias_method :valid_start_time?, :required_update_attribute_present?
      alias_method :valid_completion_location?, :required_update_attribute_present?
      alias_method :valid_location?, :required_update_attribute_present?

      def valid_editable_url?(value)
        HyperTrack::Task::VALID_EDITABLE_VALUES.include?(value.to_sym)
      end

      def update_attributes_in_object(result)
        self_keys = self.keys

        result.each do |key, value|
          if self_keys.include?(key) && self[key] != value
            self.update_value(key, value)
          end
        end

        self
      end

    end
  end
end