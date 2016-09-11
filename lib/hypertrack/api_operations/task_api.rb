module HyperTrack
  module ApiOperations
    module TaskAPI

      def editable_url(editable_url_value)
        raise "Error: Invalid editable_url: #{editable_url_value}. Allowed: #{HyperTrack::Task::VALID_EDITABLE_VALUES.join(', ')}" unless valid_editable_url?(editable_url_value)

        update_editable_url_path = "#{HyperTrack::Task::API_BASE_PATH}#{self.id}/editable_url/"
        self.update(update_editable_url_path, { editable: editable_url_value }, [:editable])
      end

      def start(params)
        start_task_path = "#{HyperTrack::Task::API_BASE_PATH}#{self.id}/start/"
        self.update(start_task_path, params, [:start_location, :start_time])
      end

      def complete(params)
        complete_task_path = "#{HyperTrack::Task::API_BASE_PATH}#{self.id}/completed/"
        self.update(complete_task_path, params, [:completion_location])
      end

      def cancel(params={})
        cancel_task_path = "#{HyperTrack::Task::API_BASE_PATH}#{self.id}/canceled/"
        self.update(cancel_task_path, params)
      end

      def update_destination(params)
        update_task_destination_path = "#{HyperTrack::Task::API_BASE_PATH}#{self.id}/update_destination/"
        self.update(update_task_destination_path, params, [:location])
      end

      private

      def valid_editable_url?(value)
        HyperTrack::Task::VALID_EDITABLE_VALUES.include?(value.to_sym)
      end

    end
  end
end