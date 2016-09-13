module HyperTrack
  class Event < HyperTrack::SharedResource

    API_BASE_PATH = "events/"
    REQUIRED_FIELDS = []

    VALID_ATTRIBUTE_VALUES = {}

    def self.create(params={})
      raise HyperTrack::MethodNotAllowed.new("Create not allowed on HyperTrack::Event class")
    end

  end
end
