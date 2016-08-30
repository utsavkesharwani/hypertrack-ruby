module HyperTrack
  class SharedResource < HyperTrack::ApiClient

    def create(params)
      result = super(self.class::API_BASE_PATH, params)
    end

    def retrieve(id)
      raise "ID is required to retrieve a #{self.class.name}" if (id.nil? || id.length.zero?)

      retrieve_customer_path = "#{self.class::API_BASE_PATH}#{id}/"
      result = fetch(retrieve_customer_path)
    end

    def list(filter_params={})
      result = fetch(self.class::API_BASE_PATH, filter_params)
    end

  end
end
