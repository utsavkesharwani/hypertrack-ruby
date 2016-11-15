require "hypertrack"
require "spec_helper"

describe HyperTrack::Trip do

  describe ".create with invalid args" do
    context "given blank string as args" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Trip.create('') }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "params missing one or all of required attributes" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Trip.create({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:driver_id]")

        expect { HyperTrack::Trip.create({ start_location: { type: "Point", coordinates: [ 72.0, 19.0 ] } }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:driver_id]")

        expect { HyperTrack::Trip.create({ tasks: ['task_id_1', 'task_id_2'] }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:driver_id]")

        expect { HyperTrack::Trip.create({ has_ordered_tasks: true }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:driver_id]")

        expect { HyperTrack::Trip.create({ driver_id: nil, tasks: ['task_id_1', 'task_id_2'] }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:driver_id]")
      end
    end

    context "params containing invalid values for vehicle_type attribute" do
      it "should raise InvalidParameters error" do
        expect {
          HyperTrack::Trip.create({
            driver_id: 'foo',
            tasks: ['task_id_1', 'task_id_2'],
            start_location: { type: "Point", coordinates: [ 72.0, 19.0 ] },
            has_ordered_tasks: false,
            vehicle_type: "random"
          })
        }.
        to raise_error(HyperTrack::InvalidParameters, /Error: Invalid vehicle_type: random. Allowed/)
      end
    end

    context "params containing invalid values for has_ordered_tasks attribute" do
      it "should raise InvalidParameters error" do
        expect {
          HyperTrack::Trip.create({
            driver_id: 'foo',
            tasks: ['task_id_1', 'task_id_2'],
            start_location: { type: "Point", coordinates: [ 72.0, 19.0 ] },
            has_ordered_tasks: 'foo-bar'
          })
        }.
        to raise_error(HyperTrack::InvalidParameters, /Error: Invalid has_ordered_tasks: foo-bar. Allowed/)
      end
    end
  end

  describe ".retrieve with invalid args" do
    context "given blank string or nil as driver_id" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Trip.retrieve('') }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Trip")

        expect { HyperTrack::Trip.retrieve(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Trip")
      end
    end
  end

  describe ".sending_eta with invalid args" do
    context "given blank string as args" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Trip.sending_eta('') }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "params missing one or all of required attributes" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Trip.sending_eta({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:driver, :destination]")

        expect { HyperTrack::Trip.sending_eta({ driver: 'foo' }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:destination]")

        expect { HyperTrack::Trip.sending_eta({ destination: 'bar' }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:driver]")
      end
    end
  end

  describe "#end_trip with invalid args" do
    context "given blank string or nil as params" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Trip.new('trip_id', {}).end_trip("") }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")

        expect { HyperTrack::Trip.new('trip_id', {}).end_trip(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "required params missing for #end_trip" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Trip.new('trip_id', {}).end_trip({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:end_location]")

        expect { HyperTrack::Trip.new('trip_id', {}).end_trip({ end_location: nil }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:end_location]")
      end
    end
  end

  describe "#add_task with invalid args" do
    context "given blank string or nil as params" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Trip.new('trip_id', {}).add_task("") }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")

        expect { HyperTrack::Trip.new('trip_id', {}).add_task(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "required params missing for #add_task" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Trip.new('trip_id', {}).add_task({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:task_id]")

        expect { HyperTrack::Trip.new('trip_id', {}).add_task({ task_id: nil }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:task_id]")
      end
    end
  end

  describe "#remove_task with invalid args" do
    context "given blank string or nil as params" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Trip.new('trip_id', {}).remove_task("") }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")

        expect { HyperTrack::Trip.new('trip_id', {}).remove_task(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "required params missing for #remove_task" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Trip.new('trip_id', {}).remove_task({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:task_id]")

        expect { HyperTrack::Trip.new('trip_id', {}).remove_task({ task_id: nil }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:task_id]")
      end
    end
  end

  describe "#change_task_order with invalid args" do
    context "given blank string or nil as params" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Trip.new('trip_id', {}).change_task_order("") }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")

        expect { HyperTrack::Trip.new('trip_id', {}).change_task_order(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "required params missing for #change_task_order" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Trip.new('trip_id', {}).change_task_order({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:task_order]")

        expect { HyperTrack::Trip.new('trip_id', {}).change_task_order({ task_order: nil }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:task_order]")
      end
    end
  end

  describe "HyperTrack::Trip class methods with valid args should return proper values" do

    before(:all) do
      HyperTrack.secret_key = "abc"

      @trip_params = {
        id: "unique_trip_id",
        driver_id: "unique_driver_id",
        tasks: ["task_id_1", "task_id_2"],
        start_location: { type: "Point", coordinates: [-122.420044, 37.774543] }
      }

      @request_headers = {
        Accept: '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        Authorization: "token #{HyperTrack.secret_key}",
        'Content-Type' => 'application/json',
        'User-Agent' => 'Ruby'
      }

      @response_trip_hash = {
        id: @trip_params[:id],
        driver_id: @trip_params[:driver_id],
        is_live: true,
        initial_eta: "2016-03-09T07:28:40.601013Z",
        eta: "2016-03-09T07:28:40.601013Z",
        start_location: @trip_params[:start_location],
        end_location: nil,
        started_at: "2016-03-09T07:13:05.026689Z",
        ended_at: nil,
        tasks: @trip_params[:tasks],
        status:  "connection_healthy",
        vehicle_type: "",
        created_at: "2016-03-09T07:13:05.026316Z",
        modified_at: "2016-03-09T07:13:06.604120Z"
      }
    end

    context ".create with valid args" do
      it "should return a HyperTrack::Trip object" do

        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Trip::API_BASE_PATH}").
          with({
            body: {
              driver_id: @trip_params[:driver_id],
              tasks: @trip_params[:tasks],
              start_location: @trip_params[:start_location],
              has_ordered_tasks: true
            }.to_json,
            headers: @request_headers
          }).
          to_return({ body: @response_trip_hash.to_json, status: 200 })

        trip_object = HyperTrack::Trip.create({
          driver_id: @trip_params[:driver_id],
          tasks: @trip_params[:tasks],
          start_location: @trip_params[:start_location],
          has_ordered_tasks: true
        })

        expect(trip_object).to be_an_instance_of HyperTrack::Trip
        expect(trip_object.id).to eq(@trip_params[:id])
        expect(trip_object.driver_id).to eq(@trip_params[:driver_id])
        expect(trip_object.tasks).to eq(@trip_params[:tasks])
        expect(Util.symbolize_keys(trip_object.start_location)).to eq(@trip_params[:start_location])
      end
    end

    context ".retrieve with valid args" do
      it "should return a HyperTrack::Trip object" do

        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Trip::API_BASE_PATH}#{@trip_params[:id]}/").
          with({ headers: @request_headers }).
          to_return({ body: @response_trip_hash.to_json, status: 200 })

        trip_object = HyperTrack::Trip.retrieve(@trip_params[:id])

        expect(trip_object).to be_an_instance_of HyperTrack::Trip
        expect(trip_object.id).to eq(@trip_params[:id])
        expect(trip_object.driver_id).to eq(@trip_params[:driver_id])
        expect(trip_object.tasks).to eq(@trip_params[:tasks])
        expect(Util.symbolize_keys(trip_object.start_location)).to eq(@trip_params[:start_location])
      end
    end

    context ".list with valid args" do
      it "should return an array of HyperTrack::Trip object(s)" do
        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Trip::API_BASE_PATH}").
          with({ headers: @request_headers }).
          to_return({ body: { count: 1, results: [@response_trip_hash] }.to_json, status: 200 })

        trips_list = HyperTrack::Trip.list

        expect(trips_list['count']).to eq(1)
        expect(trips_list['results'][0]).to be_an_instance_of HyperTrack::Trip
        expect(trips_list['results'][0].id).to eq(@trip_params[:id])
        expect(trips_list['results'][0].driver_id).to eq(@trip_params[:driver_id])
        expect(trips_list['results'][0].tasks).to eq(@trip_params[:tasks])
        expect(Util.symbolize_keys(trips_list['results'][0].start_location)).to eq(@trip_params[:start_location])
      end
    end

    context ".sending_eta with valid args" do
      it "should return required params to start tracking on SDK" do
        eta_params = {
          destination: { address: "1 Montgomery Street", city: "San Francisco" },
          driver: { phone: "+16502469293", vehicle_type: "car", name: "Tapan Pandita" }
        }
        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Trip::API_BASE_PATH}lite/").
          with({
            body: eta_params,
            headers: @request_headers
          }).
          to_return({ body: {
            driver_id: "some-driver-id",
            tracking_url: "https://eta.fyi/random-tracking-url",
            task_id: "some-task-id"
          }.to_json, status: 200 })

        api_result = HyperTrack::Trip.sending_eta(eta_params)

        expect(api_result).not_to be_an_instance_of HyperTrack::Trip
      end
    end
  end

  describe "HyperTrack::Trip instance methods with valid args should work properly" do
    before(:each) do
      HyperTrack.secret_key = "abc"

      @request_headers = {
        Accept: '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        Authorization: "token #{HyperTrack.secret_key}",
        'Content-Type' => 'application/json',
        'User-Agent' => 'Ruby'
      }

      @trip_params = {
        id: "unique_trip_id",
        driver: {
          id: "unique_driver_id",
          fleet_id: nil,
          name: "Tapan Pandita",
          phone: "+16502469293",
          photo: nil,
          vehicle_type: "car",
          created_at: "2016-03-09T04:38:10.707868Z",
          modified_at: "2016-03-09T04:47:27.102608Z"
        },
        is_live: false,
        initial_eta: "2016-03-09T07:28:40.601013Z",
        eta: "2016-03-09T07:28:40.601013Z",
        start_location: { type: "Point", coordinates: [-122.420044, 37.774543] },
        end_location: nil,
        started_at: "2016-03-09T07:13:05.026689Z",
        ended_at: nil,
        tasks: ["task_id_1", "task_id_2"],
        status: "connection_healthy",
        vehicle_type:"",
        last_known_location: {
          bearing: 0,
          speed: 0,
          created_at: "2016-03-09T07:13:05.026316Z",
          location: { type: "Point", coordinates: [-122.40383146490585, 37.80490142645246] },
          recorded_at: "2016-03-09T07:13:05.026316Z",
          trip_id: "41caa9f2-ad63-4a8b-98ed-1414c372e1ce",
          altitude: 0,
          location_accuracy: 0
        },
        created_at: "2016-03-09T07:13:05.026316Z",
        modified_at: "2016-03-09T09:06:39.079374Z"
      }

      @end_trip_params = { end_location: { type: "Point", coordinates: [-122.402248, 37.78929] } }
      @add_task_params = { task_id: "task_id_3" }
      @remove_task_params = { task_id: "task_id_3" }
      @change_task_order_params = { task_order: ["task_id_2", "task_id_1"] }
    end

    context "#end_trip with valid args" do
      it "should mark the end of the trip" do
        @trip_object = HyperTrack::Trip.new(@trip_params[:id], @trip_params)

        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Trip::API_BASE_PATH}#{@trip_params[:id]}/end/").
          with({ body: @end_trip_params, headers: @request_headers }).
          to_return({ body: @trip_params.merge(@end_trip_params).merge(ended_at: Time.now.strftime("%Y-%m-%dT%H:%M") ).to_json, status: 200 })

        updated_trip_object = @trip_object.end_trip(@end_trip_params)

        expect(updated_trip_object).to be_an_instance_of HyperTrack::Trip
        expect(updated_trip_object.id).to eq(@trip_params[:id])
        expect(Util.symbolize_keys(updated_trip_object.end_location)).to eq(@end_trip_params[:end_location])
        expect(updated_trip_object.ended_at).not_to be_nil
      end
    end

    context "#add_task with valid args" do
      it "should add task to the the trip" do
        @trip_object = HyperTrack::Trip.new(@trip_params[:id], @trip_params)

        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Trip::API_BASE_PATH}#{@trip_params[:id]}/add_task/").
          with({ body: @add_task_params, headers: @request_headers }).
          to_return({ body: @trip_params.merge({ tasks: @trip_params[:tasks] + [@add_task_params[:task_id]] }).to_json, status: 200 })

        updated_trip_object = @trip_object.add_task(@add_task_params)

        expect(updated_trip_object).to be_an_instance_of HyperTrack::Trip
        expect(updated_trip_object.id).to eq(@trip_params[:id])
        expect(updated_trip_object.tasks).to eq(@trip_params[:tasks] + [@add_task_params[:task_id]])
      end
    end

    context "#remove_task with valid args" do
      it "should remove task from the the trip" do
        @trip_object = HyperTrack::Trip.new(@trip_params[:id], @trip_params.merge({ tasks: @trip_params[:tasks] + [@add_task_params[:task_id]] }))

        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Trip::API_BASE_PATH}#{@trip_params[:id]}/remove_task/").
          with({ body: @remove_task_params, headers: @request_headers }).
          to_return({ body: @trip_params.to_json, status: 200 })

        updated_trip_object = @trip_object.remove_task(@remove_task_params)

        expect(updated_trip_object).to be_an_instance_of HyperTrack::Trip
        expect(updated_trip_object.id).to eq(@trip_params[:id])
        expect(updated_trip_object.tasks).to eq(@trip_params[:tasks])
      end
    end

    context "#change_task_order with valid args" do
      it "should update order of tasks in the trip" do
        @trip_object = HyperTrack::Trip.new(@trip_params[:id], @trip_params)

        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Trip::API_BASE_PATH}#{@trip_params[:id]}/change_task_order/").
          with({ body: @change_task_order_params, headers: @request_headers }).
          to_return({ body: @trip_params.merge(tasks: @change_task_order_params[:task_order]).to_json, status: 200 })

        updated_trip_object = @trip_object.change_task_order(@change_task_order_params)

        expect(updated_trip_object).to be_an_instance_of HyperTrack::Trip
        expect(updated_trip_object.id).to eq(@trip_params[:id])
        expect(updated_trip_object.tasks).to eq(@change_task_order_params[:task_order])
      end
    end
  end
end
