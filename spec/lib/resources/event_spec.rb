require "hypertrack"
require "spec_helper"

describe HyperTrack::Event do

  describe ".create with or without args" do
    context "given blank string as args" do
      it "should raise MethodNotAllowed error" do
        expect { HyperTrack::Event.create({}) }.
        to raise_error(HyperTrack::MethodNotAllowed, "Create not allowed on HyperTrack::Event class")

        expect { HyperTrack::Event.create('') }.
        to raise_error(HyperTrack::MethodNotAllowed, "Create not allowed on HyperTrack::Event class")

        expect { HyperTrack::Event.create() }.
        to raise_error(HyperTrack::MethodNotAllowed, "Create not allowed on HyperTrack::Event class")
      end
    end
  end

  describe ".retrieve with invalid args" do
    context "given blank string or nil as event_id" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Event.retrieve('') }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Event")

        expect { HyperTrack::Event.retrieve(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Event")
      end
    end
  end

  describe "HyperTrack::Event class methods with valid args should return proper values" do

    before(:all) do
      HyperTrack.secret_key = "abc"

      @event_params = { id: "unique_event_id" }

      @request_headers = {
        Accept: '*/*',
        'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        Authorization: "token #{HyperTrack.secret_key}",
        'Content-Type': 'application/json',
        'User-Agent': 'Ruby'
      }

      @response_event_hash = {
        id: "unique_event_id",
        event_type: "task.completed",
        event_reason: nil,
        data: {
          object: {
            id: "41caa9f2-ad63-4a8b-98ed-1414c372e1ce",
            driver_id: "d0ae4912-2074-45ef-a7c0-76be58639ea9",
            is_live: false,
            initial_eta: "2016-03-09T07:28:40.601013Z",
            eta: "2016-03-09T07:28:40.601013Z",
            start_location: {
              type: "Point",
              coordinates: [-122.420044, 37.774543]
            },
            end_location: {
              type: "Point",
              coordinates: [-122.402248, 37.78929]
            },
            started_at: "2016-03-09T07:13:05.026689Z",
            ended_at: "2016-03-09T09:06:39.073770Z",
            distance: 0,
            encoded_polyline: "",
            tasks: ["77b9a3fa-a3ab-4840-aadb-cd33442ca45b"],
            vehicle_type: "",
            created_at: "2016-03-09T07:13:05.026316Z",
            modified_at: "2016-03-09T09:06:39.079374Z"
          }
        },
        event_time: "2016-03-09T22:39:18.950318Z",
        created_at: "2016-03-09T22:39:18.950318Z",
        modified_at: "2016-03-09T22:39:18.950457Z"
      }
    end

    context ".retrieve with valid args" do
      it "should return a HyperTrack::Event object" do

        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Event::API_BASE_PATH}#{@event_params[:id]}/").
          with({ headers: @request_headers }).
          to_return({ body: @response_event_hash.to_json, status: 200 })

        event_object = HyperTrack::Event.retrieve(@event_params[:id])

        expect(event_object).to be_an_instance_of HyperTrack::Event
        expect(event_object.id).to eq(@event_params[:id])
      end
    end

    context ".list with valid args" do
      it "should return an array os HyperTrack::Event object(s)" do
        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Event::API_BASE_PATH}").
          with({ headers: @request_headers }).
          to_return({ body: { count: 1, results: [@response_event_hash] }.to_json, status: 200 })

        event_list = HyperTrack::Event.list

        expect(event_list['count']).to eq(1)
        expect(event_list['results'][0]).to be_an_instance_of HyperTrack::Event
        expect(event_list['results'][0].id).to eq(@event_params[:id])
      end
    end
  end

end
