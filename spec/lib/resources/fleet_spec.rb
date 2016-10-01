require "hypertrack"
require "spec_helper"

describe HyperTrack::Fleet do

  describe ".create with invalid args" do
    context "given blank string as args" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Fleet.create('') }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "params missing required attributes" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Fleet.create({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:name]")
      end
    end

  end

  describe ".retrieve with invalid args" do
    context "given blank string or nil as fleet_id" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Fleet.retrieve('') }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Fleet")

        expect { HyperTrack::Fleet.retrieve(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Fleet")
      end
    end
  end

  describe "HyperTrack::Fleet class methods with valid args should return proper values" do

    before(:all) do
      HyperTrack.secret_key = "abc"

      @fleet_params = { id: "unique_fleet_id", name: "foo" }

      @request_headers = {
        Accept: '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        Authorization: "token #{HyperTrack.secret_key}",
        'Content-Type' => 'application/json',
        'User-Agent' => 'Ruby'
      }

      @response_fleet_hash = {
        id: @fleet_params[:id],
        name: @fleet_params[:name],
        created_at: "2016-09-26T19:52:28.561076Z",
        modified_at: "2016-09-26T19:52:28.561110Z",
      }
    end

    context ".create with valid args" do
      it "should return a HyperTrack::Fleet object" do

        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Fleet::API_BASE_PATH}").
          with({
            body: { name: @fleet_params[:name] }.to_json,
            headers: @request_headers
          }).
          to_return({ body: @response_fleet_hash.to_json, status: 200 })

        fleet_object = HyperTrack::Fleet.create({ name: @fleet_params[:name] })

        expect(fleet_object).to be_an_instance_of HyperTrack::Fleet
        expect(fleet_object.id).to eq(@fleet_params[:id])
        expect(fleet_object.name).to eq(@fleet_params[:name])
      end
    end

    context ".retrieve with valid args" do
      it "should return a HyperTrack::Fleet object" do

        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Fleet::API_BASE_PATH}#{@fleet_params[:id]}/").
          with({ headers: @request_headers }).
          to_return({ body: @response_fleet_hash.to_json, status: 200 })

        fleet_object = HyperTrack::Fleet.retrieve(@fleet_params[:id])

        expect(fleet_object).to be_an_instance_of HyperTrack::Fleet
        expect(fleet_object.id).to eq(@fleet_params[:id])
        expect(fleet_object.name).to eq(@fleet_params[:name])
      end
    end

    context ".list with valid args" do
      it "should return an array os HyperTrack::Fleet object(s)" do
        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Fleet::API_BASE_PATH}").
          with({ headers: @request_headers }).
          to_return({ body: { count: 1, results: [@response_fleet_hash] }.to_json, status: 200 })

        fleet_list = HyperTrack::Fleet.list

        expect(fleet_list['count']).to eq(1)
        expect(fleet_list['results'][0]).to be_an_instance_of HyperTrack::Fleet
        expect(fleet_list['results'][0].id).to eq(@fleet_params[:id])
        expect(fleet_list['results'][0].name).to eq(@fleet_params[:name])
      end
    end
  end

end
