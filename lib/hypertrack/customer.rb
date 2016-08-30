module HyperTrack
  class Customer < HyperTrack::SharedResource

    API_BASE_PATH = "#{API_VERSION}/customers/"
    REQUIRED_FIELDS = [:name]

  end
end
