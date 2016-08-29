module HyperTrack

  class Customer < HyperTrack::ApiClient

    API_END_POINT = "#{API_BASE_URL}/#{API_VERSION}/customers/"

    attr_accessor :name, :phone, :email

    class << self

      def create(params)
        result = super(API_END_POINT, params)
      end

    end
  end

end