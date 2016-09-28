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

    context "given invalid value for editable_url" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Task.new('task_id', {}).editable_url({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:editable]")

        expect { HyperTrack::Task.new('task_id', {}).editable_url({ editable: nil }) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:editable]")

        expect { HyperTrack::Task.new('task_id', {}).editable_url({ editable: 'random' }) }.
        to raise_error(HyperTrack::InvalidParameters, /Error: Invalid editable: random/)
      end
    end
  end  

  describe "HyperTrack::Task methods with valid args should return proper values" do

    before(:all) do
      HyperTrack.secret_key = "abc"

      @task_params = { id: "unique_task_id" }

      @request_headers = {
        Accept: '*/*',
        'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        Authorization: "token #{HyperTrack.secret_key}",
        'Content-Type': 'application/json',
        'User-Agent': 'Ruby'
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
        "tracking_urls": [
          {
            "editable": "not editable",
            "number_of_edits": 0,
            "tracking_url": "http://eta.fyi/random-tracking-id"
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

end
