require 'hypertrack'

describe HyperTrack::ApiClient do

  describe ".get_auth_header with no secret_key set" do
    it "should raise HyperTrack::InvalidAPIKey error" do
      HyperTrack.secret_key = nil
      expect { HyperTrack::ApiClient.send(:get_auth_header) }.
      to raise_error(HyperTrack::InvalidAPIKey, "HyperTrack.secret_key is invalid.")

      HyperTrack.secret_key = ''
      expect { HyperTrack::ApiClient.send(:get_auth_header) }.
      to raise_error(HyperTrack::InvalidAPIKey, "HyperTrack.secret_key is invalid.")
    end
  end

  describe ".get_auth_header with valid secret_key set" do
    it "should return auth header" do
      HyperTrack.secret_key = "secret-key"

      header = HyperTrack::ApiClient.send(:get_auth_header)
      expect(header).to eq({ "Authorization" => "token secret-key" })
    end
  end

  describe ".path_with_params with valid args" do
    it "should update request path and append query params" do
      result = HyperTrack::ApiClient.send(:path_with_params, "/some_path", { a: 1, b: 2 })
      expect(result).to eq("/some_path?a=1&b=2")

      result = HyperTrack::ApiClient.send(:path_with_params, "/some_path", { a: { aa: 11, bb: 22 }, b: 2 })
      expect(result).to eq("/some_path?a=%7B%3Aaa%3D%3E11%2C+%3Abb%3D%3E22%7D&b=2")
    end
  end

  describe ".create_request_object with non-supported HTTP Verb" do
    it "should raise HyperTrack::MethodNotAllowed error" do
      expect { HyperTrack::ApiClient.send(:create_request_object, URI.parse("https://localhost:443/api-call"), :delete) }.
      to raise_error(HyperTrack::MethodNotAllowed, "Unsupported HTTP verb used - Only [\"GET\", \"POST\"] allowed")

      expect { HyperTrack::ApiClient.send(:create_request_object, URI.parse("https://localhost:443/api-call"), :put) }.
      to raise_error(HyperTrack::MethodNotAllowed, "Unsupported HTTP verb used - Only [\"GET\", \"POST\"] allowed")
    end
  end

  describe ".create_request_object with valid args" do
    it "should return an instance of Net::HTTP::Get / Net::HTTP::Post" do
      HyperTrack.secret_key = "secret-key"

      result = HyperTrack::ApiClient.send(:create_request_object, URI.parse("https://localhost:443/api-call"), :get)
      expect(result).to be_an_instance_of Net::HTTP::Get
      expect(result['Content-Type']).to eq('application/json')

      result = HyperTrack::ApiClient.send(:create_request_object, URI.parse("https://localhost:443/api-call"), :post)
      expect(result).to be_an_instance_of Net::HTTP::Post
      expect(result['Content-Type']).to eq('application/json')
    end
  end

  describe ".valid_response_code?" do
    it "should return true for 200 and 201 response codes" do
      expect(HyperTrack::ApiClient.send(:valid_response_code?, 200)).to eq(true)
      expect(HyperTrack::ApiClient.send(:valid_response_code?, 201)).to eq(true)
      expect(HyperTrack::ApiClient.send(:valid_response_code?, 206)).to eq(false)
      expect(HyperTrack::ApiClient.send(:valid_response_code?, 500)).to eq(false)
    end
  end

  describe ".parse_response in case of invalid response code" do
    it "should raise appropriate error" do
      response_struct = Struct.new(:code, :body)

      expect{ HyperTrack::ApiClient.send(:parse_response, response_struct.new(400, "response-body")) }.
      to raise_error(HyperTrack::InvalidParameters, "response-body")

      expect{ HyperTrack::ApiClient.send(:parse_response, response_struct.new(401, "response-body")) }.
      to raise_error(HyperTrack::InvalidAPIKey, "response-body")

      expect{ HyperTrack::ApiClient.send(:parse_response, response_struct.new(402, "response-body")) }.
      to raise_error(HyperTrack::NoFreeCreditsLeft, "response-body")

      expect{ HyperTrack::ApiClient.send(:parse_response, response_struct.new(403, "response-body")) }.
      to raise_error(HyperTrack::AccessForbidden, "response-body")

      expect{ HyperTrack::ApiClient.send(:parse_response, response_struct.new(404, "response-body")) }.
      to raise_error(HyperTrack::ResourceNotFound, "response-body")

      expect{ HyperTrack::ApiClient.send(:parse_response, response_struct.new(405, "response-body")) }.
      to raise_error(HyperTrack::MethodNotAllowed, "response-body")

      expect{ HyperTrack::ApiClient.send(:parse_response, response_struct.new(406, "response-body")) }.
      to raise_error(HyperTrack::FormatNotAcceptable, "response-body")

      expect{ HyperTrack::ApiClient.send(:parse_response, response_struct.new(410, "response-body")) }.
      to raise_error(HyperTrack::ResourceRemovedFromServer, "response-body")

      expect{ HyperTrack::ApiClient.send(:parse_response, response_struct.new(429, "response-body")) }.
      to raise_error(HyperTrack::RateLimitExceeded, "response-body")

      expect{ HyperTrack::ApiClient.send(:parse_response, response_struct.new(500, "response-body")) }.
      to raise_error(HyperTrack::InternalServerError, "response-body")

      expect{ HyperTrack::ApiClient.send(:parse_response, response_struct.new(503, "response-body")) }.
      to raise_error(HyperTrack::ServiceTemporarilyUnavailable, "response-body")

      expect{ HyperTrack::ApiClient.send(:parse_response, response_struct.new(502, "response-body")) }.
      to raise_error(HyperTrack::UnknownError, "response-body")
    end
  end

  describe ".parse_response to parse response from API call appropriately" do
    it "should parse the json response and return the parsed values" do
      parsed_response = { resource_id: "unique_resource_id" }
      response_struct = Struct.new(:code, :body)

      result = HyperTrack::ApiClient.send(:parse_response, response_struct.new(201, parsed_response.to_json))
      expect(Util.symbolize_keys(result)).to eq(parsed_response)

      result = HyperTrack::ApiClient.send(:parse_response, response_struct.new(200, parsed_response.to_json))
      expect(Util.symbolize_keys(result)).to eq(parsed_response)
    end
  end

  describe ".parse_response with invalid JSON recived from client" do
    it "should raise InvalidJSONResponse error" do
      response_struct = Struct.new(:code, :body)

      expect{ HyperTrack::ApiClient.send(:parse_response, response_struct.new(200, "response-body")) }.
      to raise_error(HyperTrack::InvalidJSONResponse, "response-body")

      expect{ HyperTrack::ApiClient.send(:parse_response, response_struct.new(201, "response-body")) }.
      to raise_error(HyperTrack::InvalidJSONResponse, "response-body")
    end
  end

end
