require "hypertrack"
require "spec_helper"

describe HyperTrack::GPSLog do

  describe ".create with or without args" do
    context "given blank string as args" do
      it "should raise MethodNotAllowed error" do
        expect { HyperTrack::GPSLog.create({}) }.
        to raise_error(HyperTrack::MethodNotAllowed, "Create not allowed on HyperTrack::GPSLog class")

        expect { HyperTrack::GPSLog.create('') }.
        to raise_error(HyperTrack::MethodNotAllowed, "Create not allowed on HyperTrack::GPSLog class")

        expect { HyperTrack::GPSLog.create() }.
        to raise_error(HyperTrack::MethodNotAllowed, "Create not allowed on HyperTrack::GPSLog class")
      end
    end
  end

  describe ".retrieve with invalid args" do
    context "given blank string or nil as gps_log_id" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::GPSLog.retrieve('') }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::GPSLog")

        expect { HyperTrack::GPSLog.retrieve(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::GPSLog")
      end
    end
  end

  describe "HyperTrack::GPSLog class methods with valid args should return proper values" do

    before(:all) do
      HyperTrack.secret_key = "abc"

      @gps_log_params = { id: "unique_gps_log_id", driver_id: "unique-driver-id" }

      @request_headers = {
        Accept: '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        Authorization: "token #{HyperTrack.secret_key}",
        'Content-Type' => 'application/json',
        'User-Agent' => 'Ruby'
      }

      @response_gps_log_hash = {
        id: @gps_log_params[:id],
        driver_id: @gps_log_params[:driver_id],
        location: { type:"Point", coordinates: [-122.421196, 37.773769] },
        location_accuracy: 20.0,
        speed: 7.0,
        bearing: 70.0,
        altitude: 80.0,
        recorded_at: "2016-03-09T07:13:05.026316Z",
        created_at: "2016-03-09T09:55:22.048718Z",
        modified_at: "2016-03-09T09:55:22.048745Z"
      }
    end

    context ".retrieve with valid args" do
      it "should return a HyperTrack::GPSLog object" do

        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::GPSLog::API_BASE_PATH}#{@gps_log_params[:id]}/").
          with({ headers: @request_headers }).
          to_return({ body: @response_gps_log_hash.to_json, status: 200 })

        gps_log_object = HyperTrack::GPSLog.retrieve(@gps_log_params[:id])

        expect(gps_log_object).to be_an_instance_of HyperTrack::GPSLog
        expect(gps_log_object.id).to eq(@gps_log_params[:id])
      end
    end

    context ".list with valid args" do
      it "should return an array os HyperTrack::GPSLog object(s)" do
        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::GPSLog::API_BASE_PATH}?raw=true").
          with({ headers: @request_headers }).
          to_return({ body: { count: 1, results: [@response_gps_log_hash] }.to_json, status: 200 })

        gps_log_list = HyperTrack::GPSLog.list

        expect(gps_log_list['count']).to eq(1)
        expect(gps_log_list['results'][0]).to be_an_instance_of HyperTrack::GPSLog
        expect(gps_log_list['results'][0].id).to eq(@gps_log_params[:id])
      end
    end

    context ".filtered_list with valid args" do
      it "should return an array os HyperTrack::GPSLog object(s)" do
        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::GPSLog::API_BASE_PATH}?driver_id=#{@gps_log_params[:driver_id]}").
          with({ headers: @request_headers }).
          to_return({ body: { count: 1, results: [@response_gps_log_hash] }.to_json, status: 200 })

        gps_log_list = HyperTrack::GPSLog.filtered_list(driver_id: @gps_log_params[:driver_id])

        expect(gps_log_list['count']).to eq(1)
        expect(gps_log_list['results'][0]).to be_an_instance_of HyperTrack::GPSLog
        expect(gps_log_list['results'][0].id).to eq(@gps_log_params[:id])
      end
    end
  end

end
