require "hypertrack"
require "spec_helper"

describe HyperTrack::Task do

  describe ".create with invalid args" do
    context "given blank string as args" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Task.create('') }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "params containing invalid values for vehicle_type attribute" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Task.create({ vehicle_type: 'random' }) }.
        to raise_error(HyperTrack::InvalidParameters, /Error: Invalid vehicle_type: random. Allowed/)
      end
    end

    context "params containing invalid values for action attribute" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Task.create({ action: 'random' }) }.
        to raise_error(HyperTrack::InvalidParameters, /Error: Invalid action: random. Allowed/)
      end
    end
  end

  describe ".retrieve with invalid args" do
    context "given blank string or nil as task_id" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Task.retrieve('') }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Task")

        expect { HyperTrack::Task.retrieve(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Task")
      end
    end
  end

  describe "#editable_url with invalid args" do
    context "given blank string or nil as params" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Task.new('task_id', {}).editable_url('') }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")

        expect { HyperTrack::Task.new('task_id', {}).editable_url(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "required params missing for editable_url" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Task.new('task_id', {}).editable_url({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:editable]")

        expect { HyperTrack::Task.new('task_id', {}).editable_url({ editable: nil }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:editable]")
      end
    end

    context "given invalid value for editable_url" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Task.new('task_id', {}).editable_url({ editable: 'random' }) }.
        to raise_error(HyperTrack::InvalidParameters, /Error: Invalid editable: random/)
      end
    end
  end

  describe "#start with invalid args" do
    context "given blank string or nil as params" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Task.new('task_id', {}).start('') }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")

        expect { HyperTrack::Task.new('task_id', {}).start(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "one or all required params missing for start" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Task.new('task_id', {}).start({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:start_location, :start_time]")

        expect { HyperTrack::Task.new('task_id', {}).start({ start_time: Time.now.strftime("%Y-%m-%dT%H:%M") }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:start_location]")

        expect { HyperTrack::Task.new('task_id', {}).start({ start_location: { type: "Point", coordinates: [ 72.0, 19.0 ] } }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:start_time]")
      end
    end
  end

  describe "#complete with invalid args" do
    context "given blank string or nil as params" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Task.new('task_id', {}).complete('') }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")

        expect { HyperTrack::Task.new('task_id', {}).complete(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "required params missing for complete" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Task.new('task_id', {}).complete({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:completion_location]")

        expect { HyperTrack::Task.new('task_id', {}).complete({ completion_location: nil }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:completion_location]")
      end
    end
  end

  describe "#update_destination with invalid args" do
    context "given blank string or nil as params" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Task.new('task_id', {}).update_destination('') }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")

        expect { HyperTrack::Task.new('task_id', {}).update_destination(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "required params missing for start" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Task.new('task_id', {}).update_destination({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:location]")

        expect { HyperTrack::Task.new('task_id', {}).update_destination({ location: nil }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:location]")
      end
    end
  end

  describe "HyperTrack::Task class methods with valid args should return proper values" do

    before(:all) do
      HyperTrack.secret_key = "abc"

      @task_params = { id: "unique_task_id" }

      @request_headers = {
        Accept: '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        Authorization: "token #{HyperTrack.secret_key}",
        'Content-Type' => 'application/json',
        'User-Agent' => 'Ruby'
      }

      @response_task_hash = {
        id: @task_params[:id],
        trip_id: nil,
        destination_id: nil,
        driver_id: nil,
        action: "task",
        status: "not_started",
        eta: nil,
        initial_eta: nil,
        committed_eta: nil,
        start_time: nil,
        start_location: nil,
        completion_time: nil,
        completion_location: nil,
        order_id: nil,
        tracking_url:  "http://eta.fyi/random-tracking-id",
        tracking_urls: [
          {
            editable: "not editable",
            number_of_edits: 0,
            tracking_url: "http://eta.fyi/random-tracking-id"
          }
        ],
        created_at: "2016-09-26T19:52:28.561076Z",
        modified_at: "2016-09-26T19:52:28.561110Z",
      }
    end

    context ".create with valid args" do
      it "should return a HyperTrack::Task object" do

        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Task::API_BASE_PATH}").
          with({ headers: @request_headers }).
          to_return({ body: @response_task_hash.to_json, status: 200 })

        task_object = HyperTrack::Task.create()

        expect(task_object).to be_an_instance_of HyperTrack::Task
        expect(task_object.id).to eq(@task_params[:id])
      end
    end

    context ".retrieve with valid args" do
      it "should return a HyperTrack::Task object" do

        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Task::API_BASE_PATH}#{@task_params[:id]}/").
          with({ headers: @request_headers }).
          to_return({ body: @response_task_hash.to_json, status: 200 })

        task_object = HyperTrack::Task.retrieve(@task_params[:id])

        expect(task_object).to be_an_instance_of HyperTrack::Task
        expect(task_object.id).to eq(@task_params[:id])
      end
    end

    context ".list with valid args" do
      it "should return an array os HyperTrack::Task object(s)" do
        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Task::API_BASE_PATH}").
          with({ headers: @request_headers }).
          to_return({ body: { count: 1, results: [@response_task_hash] }.to_json, status: 200 })

        task_list = HyperTrack::Task.list

        expect(task_list['count']).to eq(1)
        expect(task_list['results'][0]).to be_an_instance_of HyperTrack::Task
        expect(task_list['results'][0].id).to eq(@task_params[:id])
      end
    end
  end

  describe "HyperTrack::Task instance methods with valid args should work properly" do
    before(:each) do
      HyperTrack.secret_key = "abc"

      @request_headers = {
        Accept: '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        Authorization: "token #{HyperTrack.secret_key}",
        'Content-Type' => 'application/json',
        'User-Agent' => 'Ruby'
      }

      @task_params = {
        id: "unique_task_id",
        trip_id: nil,
        destination_id: nil,
        driver_id: nil,
        action: "task",
        status: "not_started",
        eta: nil,
        initial_eta: nil,
        committed_eta: nil,
        start_time: nil,
        start_location: nil,
        completion_time: nil,
        completion_location: nil,
        cancelation_time: nil,
        order_id: nil,
        tracking_url:  "http://eta.fyi/random-tracking-id",
        tracking_urls: [
          {
            editable: "multiple",
            number_of_edits: 0,
            tracking_url: "http://eta.fyi/random-tracking-id"
          }
        ],
        created_at: "2016-09-26T19:52:28.561076Z",
        modified_at: "2016-09-26T19:52:28.561110Z",
      }

      @start_task_params = { start_location: { type: "Point", coordinates: [ 72.0, 19.0 ] }, start_time: Time.now.strftime("%Y-%m-%dT%H:%M") }
      @complete_task_params = { completion_location: { type: "Point", coordinates: [ 72.0, 19.1 ] }, completion_time: Time.now.strftime("%Y-%m-%dT%H:%M") }
      @cancel_task_params = { cancelation_time: Time.now.strftime("%Y-%m-%dT%H:%M") }
      @update_dest_task_params = { location: { type: "Point", coordinates: [ 72.0, 18.0 ] } }
    end

    context "#editable_url with valid args" do
      it "should return editable tracking url" do
        @task_object = HyperTrack::Task.new(@task_params[:id], @task_params)

        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Task::API_BASE_PATH}#{@task_params[:id]}/editable_url/").
          with({ body: { editable: 'multiple' }, headers: @request_headers }).
          to_return({ body: {
            tracking_url: "http://eta.fyi/Gb7Kp5",
            editable: "multiple",
            number_of_edits: 0
          }.to_json, status: 200 })

        new_editable_url = @task_object.editable_url(editable: "multiple")

        expect(new_editable_url).not_to be_an_instance_of HyperTrack::Task
      end
    end

    context "#start with valid args" do
      it "should mark the start of the task" do
        @task_object = HyperTrack::Task.new(@task_params[:id], @task_params)

        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Task::API_BASE_PATH}#{@task_params[:id]}/start/").
          with({ body: @start_task_params, headers: @request_headers }).
          to_return({ body: @task_params.merge(@start_task_params).to_json, status: 200 })

        updated_task_object = @task_object.start(@start_task_params)

        expect(updated_task_object).to be_an_instance_of HyperTrack::Task
        expect(updated_task_object.id).to eq(@task_params[:id])
        expect(updated_task_object.start_time).to eq(@start_task_params[:start_time])
        expect(Util.symbolize_keys(updated_task_object.start_location)).to eq(@start_task_params[:start_location])
      end
    end

    context "#complete with valid args" do
      it "should mark the end of the task" do
        @task_object = HyperTrack::Task.new(@task_params[:id], @task_params.merge(@start_task_params))

        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Task::API_BASE_PATH}#{@task_params[:id]}/completed/").
          with({ body: @complete_task_params, headers: @request_headers }).
          to_return({ body: @task_params.merge(@start_task_params).merge(@complete_task_params).to_json, status: 200 })

        updated_task_object = @task_object.complete(@complete_task_params)

        expect(updated_task_object).to be_an_instance_of HyperTrack::Task
        expect(updated_task_object.id).to eq(@task_params[:id])
        expect(updated_task_object.start_time).to eq(@start_task_params[:start_time])
        expect(Util.symbolize_keys(updated_task_object.start_location)).to eq(@start_task_params[:start_location])
        expect(Util.symbolize_keys(updated_task_object.completion_location)).to eq(@complete_task_params[:completion_location])
        expect(updated_task_object.completion_time).to eq(@complete_task_params[:completion_time])
      end
    end

    context "#cancel with valid args" do
      it "should mark the cancellation of the task" do
        @task_object = HyperTrack::Task.new(@task_params[:id], @task_params.merge(@start_task_params))

        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Task::API_BASE_PATH}#{@task_params[:id]}/canceled/").
          with({ body: @cancel_task_params, headers: @request_headers }).
          to_return({ body: @task_params.merge(@start_task_params).merge(@cancel_task_params).to_json, status: 200 })

        updated_task_object = @task_object.cancel(@cancel_task_params)

        expect(updated_task_object).to be_an_instance_of HyperTrack::Task
        expect(updated_task_object.id).to eq(@task_params[:id])
        expect(updated_task_object.start_time).to eq(@start_task_params[:start_time])
        expect(updated_task_object.completion_location).to be_nil
        expect(updated_task_object.completion_time).to be_nil
        expect(updated_task_object.cancelation_time).to eq(@cancel_task_params[:cancelation_time])
      end
    end

    context "#update_destination with valid args" do
      it "should update the destination of the task" do
        @task_object = HyperTrack::Task.new(@task_params[:id], @task_params.merge(@start_task_params))

        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Task::API_BASE_PATH}#{@task_params[:id]}/update_destination/").
          with({ body: @update_dest_task_params, headers: @request_headers }).
          to_return({ body: @task_params.merge(start_location: @update_dest_task_params[:location]).to_json, status: 200 })

        updated_task_object = @task_object.update_destination(@update_dest_task_params)

        expect(updated_task_object).to be_an_instance_of HyperTrack::Task
        expect(updated_task_object.id).to eq(@task_params[:id])
        expect(Util.symbolize_keys(updated_task_object.start_location)).not_to eq(@start_task_params[:start_location])
        expect(Util.symbolize_keys(updated_task_object.start_location)).to eq(@update_dest_task_params[:location])
      end
    end
  end

end
