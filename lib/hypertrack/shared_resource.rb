module HyperTrack
  class SharedResource < HyperTrack::ApiClient

    VALID_VEHICLE_TYPES = [:walking, :bicycle, :motorcycle, :car, :'3-wheeler', :van, :flight, :train, :ship]

    def create(params)
      raise "Error: Expected a Hash. Got: #{params}" unless valid_create_params?(params)

      params = Util.symbolize_keys(params)

      raise "Request is missing required params - #{self.class::REQUIRED_FIELDS - params.keys}" if missing_required_fields?(params)

      result = super(self.class::API_BASE_PATH, params)
    end

    def retrieve(id)
      raise "ID is required to retrieve a #{self.class.name}" unless valid_retrieve_id?(id)

      retrieve_customer_path = "#{self.class::API_BASE_PATH}#{id}/"
      result = fetch(retrieve_customer_path)
    end

    def list(filter_params={})
      result = fetch(self.class::API_BASE_PATH, filter_params)
    end

    private

    def missing_required_fields?(params)
      self.class::REQUIRED_FIELDS.each do |field|
        return true if Util.blank?(params[field])
      end

      false
    end

    def valid_create_params?(params)
      params.is_a?(Hash)
    end

    def valid_vehicle_type?(vehicle)
      VALID_VEHICLE_TYPES.include?(vehicle.to_s.downcase.to_sym)
    end

    def valid_retrieve_id?(id)
      !Util.blank?(id)
    end

  end
end
