module HyperTrack
  class Task < HyperTrack::SharedResource

    API_BASE_PATH = "#{API_VERSION}/tasks/"
    REQUIRED_FIELDS = []
    VALID_ACTIONS = [:pickup, :delivery, :visit, :task]

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
end
