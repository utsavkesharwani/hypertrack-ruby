require "hypertrack"
require "spec_helper"

describe HyperTrack::Shift do

  describe ".create with invalid args" do
    context "given blank string as args" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Shift.create('') }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "params missing one or all of required attributes" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Shift.create({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:driver_id, :start_location]")

        expect { HyperTrack::Shift.create({ start_location: { type: "Point", coordinates: [ 72.0, 19.0 ] } }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:driver_id]")

        expect { HyperTrack::Shift.create({ driver_id: 'some_driver_id' }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:start_location]")
      end
    end
  end

  describe ".retrieve with invalid args" do
    context "given blank string or nil as shift_id" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Shift.retrieve('') }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Shift")

        expect { HyperTrack::Shift.retrieve(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Shift")
      end
    end
  end

  describe "#end_shift with invalid args" do
    context "given blank string or nil as params" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Shift.new('shift_id', {}).end_shift('') }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")

        expect { HyperTrack::Shift.new('shift_id', {}).end_shift(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "required params missing for end_shift" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Shift.new('shift_id', {}).end_shift({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:end_location]")

        expect { HyperTrack::Shift.new('shift_id', {}).end_shift({ end_location: nil }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:end_location]")
      end
    end
  end

  describe "HyperTrack::Shift class methods with valid args should return proper values" do

    before(:all) do
      HyperTrack.secret_key = "abc"

      @shift_params = { id: "unique_shift_id", driver_id: "some_driver_id", start_location: { type: "Point", coordinates: [ 72.0, 19.0 ] } }

      @request_headers = {
        Accept: '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        Authorization: "token #{HyperTrack.secret_key}",
        'Content-Type' => 'application/json',
        'User-Agent' => 'Ruby'
      }

      @response_shift_hash = {
        created_at: "2016-07-15T07:36:39.100626Z",
        distance: nil,
        driver_id: @shift_params[:driver_id],
        encoded_polyline: "",
        end_location: nil,
        ended_at: nil,
        id: @shift_params[:id],
        is_active: true,
        modified_at: "2016-07-15T07:36:39.100654Z",
        start_location: @shift_params[:start_location],
        started_at: "2016-07-15T07:36:39.100912Z"
      }
    end

    context ".create with valid args" do
      it "should return a HyperTrack::Shift object" do

        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Shift::API_BASE_PATH}").
          with({
            body: { driver_id: @shift_params[:driver_id], start_location: @shift_params[:start_location] }.to_json,
            headers: @request_headers
          }).
          to_return({ body: @response_shift_hash.to_json, status: 200 })

        shift_object = HyperTrack::Shift.create({ driver_id: @shift_params[:driver_id], start_location: @shift_params[:start_location] })

        expect(shift_object).to be_an_instance_of HyperTrack::Shift
        expect(shift_object.id).to eq(@shift_params[:id])
        expect(shift_object.driver_id).to eq(@shift_params[:driver_id])
        expect(Util.symbolize_keys(shift_object.start_location)).to eq(@shift_params[:start_location])
      end
    end

    context ".retrieve with valid args" do
      it "should return a HyperTrack::Shift object" do

        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Shift::API_BASE_PATH}#{@shift_params[:id]}/").
          with({ headers: @request_headers }).
          to_return({ body: @response_shift_hash.to_json, status: 200 })

        shift_object = HyperTrack::Shift.retrieve(@shift_params[:id])

        expect(shift_object).to be_an_instance_of HyperTrack::Shift
        expect(shift_object.id).to eq(@shift_params[:id])
        expect(shift_object.driver_id).to eq(@shift_params[:driver_id])
        expect(Util.symbolize_keys(shift_object.start_location)).to eq(@shift_params[:start_location])
      end
    end

    context ".list with valid args" do
      it "should return an array of HyperTrack::Shift object(s)" do
        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Shift::API_BASE_PATH}").
          with({ headers: @request_headers }).
          to_return({ body: { count: 1, results: [@response_shift_hash] }.to_json, status: 200 })

        shift_list = HyperTrack::Shift.list

        expect(shift_list['count']).to eq(1)
        expect(shift_list['results'][0]).to be_an_instance_of HyperTrack::Shift
        expect(shift_list['results'][0].id).to eq(@shift_params[:id])
        expect(shift_list['results'][0].driver_id).to eq(@shift_params[:driver_id])
        expect(Util.symbolize_keys(shift_list['results'][0].start_location)).to eq(@shift_params[:start_location])
      end
    end
  end

  describe "HyperTrack::Shift instance methods with valid args should return proper values" do
    before(:each) do
      HyperTrack.secret_key = "abc"

      @request_headers = {
        Accept: '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        Authorization: "token #{HyperTrack.secret_key}",
        'Content-Type' => 'application/json',
        'User-Agent' => 'Ruby'
      }

      @shift_params = {
        id: "unique_shift_id",
        driver: {
          id: "unique_driver_id",
          fleet: nil,
          name: "Foo",
          phone: "",
          photo: nil,
          vehicle_type: "car",
          location: { type: "Point", coordinates: [72.0, 19.0] },
          location_recorded_at: "2016-07-18T09:57:02.705710Z",
          created_at: "2016-06-16T10:26:13.561021Z",
          lookup_id: "",
          modified_at: "2016-07-13T05:22:48.660418Z",
          last_known_location: {},
          last_heartbeat: "2016-07-14T02:46:58.718845Z",
          battery_level: nil
        },
        is_active: true,
        start_location: { type: "Point", coordinates: [72.0, 19.0] },
        end_location: nil,
        started_at: "2016-07-15T07:38:00.046938Z",
        ended_at: nil,
        encoded_polyline: "23woculpi3-",
        distance: 15,
        created_at: "2016-07-15T07:38:00.046642Z",
        modified_at: "2016-07-15T07:38:33.928389Z"
      }

      @end_location = { type: "Point", coordinates: [72.0, 19.2] }
      @end_time = Time.now.strftime("%Y-%m-%dT%H:%M")
      @shift_object = HyperTrack::Shift.new(@shift_params[:id], @shift_params)
    end

    context "#end_shift with valid args" do
      it "should return a HyperTrack::Shift object with updated attributes" do
        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Shift::API_BASE_PATH}#{@shift_object[:id]}/end/").
        with({
          body: { end_location: @end_location, end_time: @end_time }.to_json,
          headers: @request_headers
        }).
        to_return({ body: @shift_params.merge({ end_location: @end_location, ended_at: @end_time, is_active: false }).to_json, status: 200 })

        @shift_object.end_shift({ end_location: @end_location, end_time: @end_time })

        expect(@shift_object).to be_an_instance_of HyperTrack::Shift
        expect(Util.symbolize_keys(@shift_object.end_location)).to eq(@end_location)
        expect(@shift_object.ended_at).to eq(@end_time)
        expect(@shift_object.is_active).to eq(false)
      end
    end
  end

end
