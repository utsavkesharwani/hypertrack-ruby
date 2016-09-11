module HyperTrack
  class Customer < HyperTrack::SharedResource

    API_BASE_PATH = "customers/"
    REQUIRED_FIELDS = [:name]

    VALID_ATTRIBUTE_VALUES = {}

  end
end
