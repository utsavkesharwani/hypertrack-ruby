module HyperTrack
  class Driver < HyperTrack::SharedResource

    API_BASE_PATH = "#{API_VERSION}/drivers/"
    REQUIRED_FIELDS = [:name, :vehicle_type]

  end
end
