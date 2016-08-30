module HyperTrack
  class SharedResource < HyperTrack::ApiClient

    def create(params)
      params = Util.symbolize_keys(params)

      if missing_required_fields?(params)
        raise "Request is missing required params - #{self.class::REQUIRED_FIELDS - params.keys}"
      end

      result = super(self.class::API_BASE_PATH, params)
    end

    def retrieve(id)
      raise "ID is required to retrieve a #{self.class.name}" if Util.blank?(id)

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
    end

  end
end
