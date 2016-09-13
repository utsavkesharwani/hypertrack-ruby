module HyperTrack
  class Neighbourhood < HyperTrack::SharedResource

    API_BASE_PATH = "neighborhoods/"
    REQUIRED_FIELDS = []

    VALID_ATTRIBUTE_VALUES = {}

    def self.create(params={})
      raise HyperTrack::MethodNotAllowed.new("Create not allowed on HyperTrack::Neighbourhood class")
    end

  end
end
