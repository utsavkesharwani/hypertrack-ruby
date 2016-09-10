module HyperTrack
  class Task < HyperTrack::SharedResource

    API_BASE_PATH = "tasks/"
    REQUIRED_FIELDS = []
    VALID_ACTIONS = [:pickup, :delivery, :visit, :task]
    VALID_EDITABLE_VALUES = [:'not editable', :once, :multiple]

    class << self

      def create(params)
        # To-Do: Add a common validator, like before_filter in Rails
        raise "Error: Expected a Hash. Got: #{params}" unless valid_create_params?(params)

        params = Util.symbolize_keys(params)

        raise "Error: Invalid action: #{params[:action]}. Allowed: #{VALID_ACTIONS.join(', ')}" unless valid_task_action?(params[:action])
        raise "Error: Invalid vehicle_type: #{params[:vehicle_type]}. Allowed: #{VALID_VEHICLE_TYPES.join(', ')}" unless valid_vehicle_type?(params[:vehicle_type])

        super
      end

      private

      def valid_task_action?(action)
        Util.blank?(action) || VALID_ACTIONS.include?(action.to_s.to_sym)
      end

    end

    def editable_url(id, editable)
      raise "Error: Invalid editable_url: #{editable}. Allowed: #{VALID_EDITABLE_VALUES.join(', ')}" unless valid_editable_url?(editable)
    end

    private

    def valid_editable_url?(value)
      VALID_EDITABLE_VALUES.include?(value)
    end

  end
end
