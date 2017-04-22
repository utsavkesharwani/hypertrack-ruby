module HyperTrack
  class ApiClient

    BASE_URL = "https://api.hypertrack.com/api"
    API_VERSION = "v1"

    VERB_MAP = {
      :get  => Net::HTTP::Get,
      :post => Net::HTTP::Post
    }

    ACCEPTED_RESPONSE_CODES = [200, 201]

    class << self

      def create(api_path, data={})
        api_uri = get_uri(api_path)
        request_object = create_request_object(api_uri, :post)
        request_object.body = data.to_json
        make_request(api_uri, request_object)
      end
      alias_method :update, :create

      def fetch(api_path, query_params={})
        api_path = path_with_params(api_path, query_params) if query_params.is_a?(Hash) && query_params.keys.length > 0
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
        if Util.blank?(HyperTrack.secret_key)
          raise HyperTrack::InvalidAPIKey.new("HyperTrack.secret_key is invalid.")
        end

        { "Authorization" => "token #{HyperTrack.secret_key}" }
      end

      def get_uri(path)
        url = "#{BASE_URL}/#{API_VERSION}/#{path}"
        URI.parse(url)
      end

      def create_request_object(api_uri, http_method)
        if VERB_MAP[http_method].nil?
          raise HyperTrack::MethodNotAllowed.new("Unsupported HTTP verb used - Only #{VERB_MAP.keys.map{ |x| x.to_s.upcase }} allowed")
        end

        header = get_auth_header
        request_object = VERB_MAP[http_method].new(api_uri.request_uri, header)
        request_object['Content-Type'] = 'application/json'
        request_object
      end

      # To-Do: Add a timeout
      def make_request(api_uri, request_object)
        conn = Net::HTTP.new api_uri.host, api_uri.port
        conn.use_ssl = api_uri.scheme == 'https'
        conn.verify_mode = OpenSSL::SSL::VERIFY_PEER
        conn.cert_store = OpenSSL::X509::Store.new
        conn.cert_store.set_default_paths
        parse_response(conn.request(request_object))
      end

      def parse_response(response)
        response_code = response.code.to_i

        if valid_response_code?(response_code)
          begin
            JSON.parse(response.body)
          rescue JSON::ParserError => e
            raise HyperTrack::InvalidJSONResponse.new(response.body)
          end
        else
          error_klass = HyperTrack::Error.defined_codes[response_code] || HyperTrack::UnknownError
          raise error_klass.new(response.body, response_code)
        end
      end

      def valid_response_code?(code)
        ACCEPTED_RESPONSE_CODES.include?(code)
      end

    end

  end
end
