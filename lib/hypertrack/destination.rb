module HyperTrack
  class Destination < HyperTrack::SharedResource

    API_BASE_PATH = "#{API_VERSION}/destinations/"
    REQUIRED_FIELDS = [:customer_id]

  end
end
