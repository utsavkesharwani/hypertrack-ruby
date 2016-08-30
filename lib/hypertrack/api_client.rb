require "net/https"

module HyperTrack

  class ApiClient

    BASE_URL = "https://app.hypertrack.io/api"
    API_VERSION = "v1"

    VERB_MAP = {
      :get  => Net::HTTP::Get,
      :post => Net::HTTP::Post,
    }

    attr_accessor :secret_key

    def initialize(secret_key)
      @secret_key = secret_key
    end

    def create(api_path, data)
      api_uri = get_uri(api_path)
      request_object = create_request_object(api_uri, :post)
      request_object.body = data.to_json
      make_request(api_uri, request_object)
    end

    def fetch(api_path, query_params={})
      api_path = path_with_params(api_path, query_params) if query_params.is_a?(Hash) && query_params.keys.length > 0
      puts api_path
      api_uri = get_uri(api_path)
      request_object = create_request_object(api_uri, :get)
      make_request(api_uri, request_object)
    end

    private

    def path_with_params(path, params)
      encoded_params = URI.encode_www_form(params)
      [path, encoded_params].join("?")
    end

    def get_auth_header
      { "Authorization" => "token #{self.secret_key}" }
    end

    def get_uri(path)
      url = "#{BASE_URL}/#{path}"
      URI.parse(url)
    end

    def create_request_object(api_uri, http_method)
      raise 'Unsupported HTTP verb used - Only GET, POST allowed' if VERB_MAP[http_method].nil?

      header = get_auth_header
      request_object = VERB_MAP[http_method].new(api_uri.path, header)
      request_object['Content-Type'] = 'application/json'
      request_object
    end

    def make_request(api_uri, request_object)
      conn = Net::HTTP.new api_uri.host, api_uri.port
      conn.use_ssl = api_uri.scheme == 'https'
      conn.verify_mode = OpenSSL::SSL::VERIFY_PEER
      conn.cert_store = OpenSSL::X509::Store.new
      conn.cert_store.set_default_paths
      conn.request(request_object)
    end

  end
end
