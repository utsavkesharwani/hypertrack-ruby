require "hypertrack"
require "spec_helper"

describe HyperTrack::Hub do

  describe ".create with invalid args" do
    context "given blank string as args" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Hub.create('') }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "params missing required attributes" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Hub.create({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:name]")
      end
    end

  end

  describe ".retrieve with invalid args" do
    context "given blank string or nil as hub_id" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Hub.retrieve('') }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Hub")

        expect { HyperTrack::Hub.retrieve(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Hub")
      end
    end
  end

  describe "HyperTrack::Hub class methods with valid args should return proper values" do

    before(:all) do
      HyperTrack.secret_key = "abc"

      @hub_params = { id: "unique_hub_id", name: "foo" }

      @request_headers = {
        Accept: '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        Authorization: "token #{HyperTrack.secret_key}",
        'Content-Type' => 'application/json',
        'User-Agent' => 'Ruby'
      }

      @response_hub_hash = {
        id: @hub_params[:id],
        name: @hub_params[:name],
        address: "",
        landmark: "",
        zip_code: "",
        city: "",
        state: "",
        country: "",
        location: nil,
        created_at: "2016-09-26T19:52:28.561076Z",
        modified_at: "2016-09-26T19:52:28.561110Z",
      }
    end

    context ".create with valid args" do
      it "should return a HyperTrack::Hub object" do

        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Hub::API_BASE_PATH}").
          with({
            body: { name: @hub_params[:name] }.to_json,
            headers: @request_headers
          }).
          to_return({ body: @response_hub_hash.to_json, status: 200 })

        hub_object = HyperTrack::Hub.create({ name: @hub_params[:name] })

        expect(hub_object).to be_an_instance_of HyperTrack::Hub
        expect(hub_object.id).to eq(@hub_params[:id])
        expect(hub_object.name).to eq(@hub_params[:name])
      end
    end

    context ".retrieve with valid args" do
      it "should return a HyperTrack::Hub object" do

        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Hub::API_BASE_PATH}#{@hub_params[:id]}/").
          with({ headers: @request_headers }).
          to_return({ body: @response_hub_hash.to_json, status: 200 })

        hub_object = HyperTrack::Hub.retrieve(@hub_params[:id])

        expect(hub_object).to be_an_instance_of HyperTrack::Hub
        expect(hub_object.id).to eq(@hub_params[:id])
        expect(hub_object.name).to eq(@hub_params[:name])
      end
    end

    context ".list with valid args" do
      it "should return an array os HyperTrack::Hub object(s)" do
        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Hub::API_BASE_PATH}").
          with({ headers: @request_headers }).
          to_return({ body: { count: 1, results: [@response_hub_hash] }.to_json, status: 200 })

        hub_list = HyperTrack::Hub.list

        expect(hub_list['count']).to eq(1)
        expect(hub_list['results'][0]).to be_an_instance_of HyperTrack::Hub
        expect(hub_list['results'][0].id).to eq(@hub_params[:id])
        expect(hub_list['results'][0].name).to eq(@hub_params[:name])
      end
    end
  end

end
