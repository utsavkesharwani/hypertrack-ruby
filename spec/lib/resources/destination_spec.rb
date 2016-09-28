require "hypertrack"
require "spec_helper"

describe HyperTrack::Destination do

  describe ".create with invalid args" do
    context "given blank string as args" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Destination.create('') }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "params missing required attributes" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Destination.create({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:customer_id]")
      end
    end

  end

  describe ".retrieve with invalid args" do
    context "given blank string or nil as destination_id" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Destination.retrieve('') }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Destination")

        expect { HyperTrack::Destination.retrieve(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Destination")
      end
    end
  end

  describe "HyperTrack::Destination methods with valid args should return proper values" do

    before(:all) do
      HyperTrack.secret_key = "abc"

      @destination_params = { id: "unique_destination_id", customer_id: "unique_customer_id" }

      @request_headers = {
        Accept: '*/*',
        'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        Authorization: "token #{HyperTrack.secret_key}",
        'Content-Type': 'application/json',
        'User-Agent': 'Ruby'
      }

      @response_destination_hash = {
        id: @destination_params[:id],
        customer_id: @destination_params[:customer_id],
        address: "",
        zip_code: "",
        city: "",
        state: "",
        country: "",
        location: {},
        created_at: "2016-09-26T19:52:28.561076Z",
        modified_at: "2016-09-26T19:52:28.561110Z",
      }
    end

    context ".create with valid args" do
      it "should return a HyperTrack::Destination object" do

        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Destination::API_BASE_PATH}").
          with({
            body: { customer_id: @destination_params[:customer_id] }.to_json,
            headers: @request_headers
          }).
          to_return({ body: @response_destination_hash.to_json, status: 200 })

        destination_object = HyperTrack::Destination.create({ customer_id: @destination_params[:customer_id] })

        expect(destination_object).to be_an_instance_of HyperTrack::Destination
        expect(destination_object.id).to eq(@destination_params[:id])
        expect(destination_object.customer_id).to eq(@destination_params[:customer_id])
      end
    end

    context ".retrieve with valid args" do
      it "should return a HyperTrack::Destination object" do

        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Destination::API_BASE_PATH}#{@destination_params[:id]}/").
          with({ headers: @request_headers }).
          to_return({ body: @response_destination_hash.to_json, status: 200 })

        destination_object = HyperTrack::Destination.retrieve(@destination_params[:id])

        expect(destination_object).to be_an_instance_of HyperTrack::Destination
        expect(destination_object.id).to eq(@destination_params[:id])
        expect(destination_object.customer_id).to eq(@destination_params[:customer_id])
      end
    end

    context ".list with valid args" do
      it "should return an array os HyperTrack::Destination object(s)" do
        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Destination::API_BASE_PATH}").
          with({ headers: @request_headers }).
          to_return({ body: { count: 1, results: [@response_destination_hash] }.to_json, status: 200 })

        destination_list = HyperTrack::Destination.list

        expect(destination_list['count']).to eq(1)
        expect(destination_list['results'][0]).to be_an_instance_of HyperTrack::Destination
        expect(destination_list['results'][0].id).to eq(@destination_params[:id])
        expect(destination_list['results'][0].customer_id).to eq(@destination_params[:customer_id])
      end
    end
  end

end
