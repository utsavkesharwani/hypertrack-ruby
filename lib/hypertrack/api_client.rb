require "net/https"

module HyperTrack

  class ApiClient

    API_BASE_URL = "https://app.hypertrack.io/api"
    API_VERSION = "v1"

    class << self

      def create(api_url, data)
        make_request(api_url, data)
      end

      def make_request(api_url, data)
        api_uri = URI.parse api_url
        conn = Net::HTTP.new api_uri.host, api_uri.port
        conn.use_ssl = api_uri.scheme == 'https'
        conn.verify_mode = OpenSSL::SSL::VERIFY_PEER
        conn.cert_store = OpenSSL::X509::Store.new
        conn.cert_store.set_default_paths
        header = { "Authorization" => "token #{HyperTrackAPI::SECRET_KEY}" }
        req = Net::HTTP::Post.new(api_uri.path, header)
        req['Content-Type'] = 'application/json'
        req.body = data.to_json
        res = conn.request(req)

        res
      end

    end
  end
end
