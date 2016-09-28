require "hypertrack"
require "spec_helper"

describe HyperTrack::Customer do

  describe ".create with invalid args" do
    context "given blank string as args" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Customer.create('') }.
        to raise_error(HyperTrack::InvalidParameters, "Error: Expected a Hash. Got: ")
      end
    end

    context "params missing required attributes" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Customer.create({}) }.
        to raise_error(HyperTrack::InvalidParameters, "Request is missing required params - [:name]")
      end
    end

  end

  describe ".retrieve with invalid args" do
    context "given blank string or nil as customer_id" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Customer.retrieve('') }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Customer")

        expect { HyperTrack::Customer.retrieve(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Customer")
      end
    end
  end

  describe "HyperTrack::Customer methods with valid args should return proper values" do

    before(:all) do
      HyperTrack.secret_key = "abc"

      @customer_params = { id: "unique_customer_id", name: "foo" }

      @request_headers = {
        Accept: '*/*',
        'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        Authorization: "token #{HyperTrack.secret_key}",
        'Content-Type': 'application/json',
        'User-Agent': 'Ruby'
      }

      @response_customer_hash = {
        id: @customer_params[:id],
        name: @customer_params[:name],
        phone: "",
        email: "",
        created_at: "2016-09-26T19:52:28.561076Z",
        modified_at: "2016-09-26T19:52:28.561110Z",
      }
    end

    context ".create with valid args" do
      it "should return a HyperTrack::Customer object" do

        stub_request(:post, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Customer::API_BASE_PATH}").
          with({
            body: { name: @customer_params[:name] }.to_json,
            headers: @request_headers
          }).
          to_return({ body: @response_customer_hash.to_json, status: 200 })

        customer_object = HyperTrack::Customer.create({ name: @customer_params[:name] })

        expect(customer_object).to be_an_instance_of HyperTrack::Customer
        expect(customer_object.id).to eq(@customer_params[:id])
        expect(customer_object.name).to eq(@customer_params[:name])
      end
    end

    context ".retrieve with valid args" do
      it "should return a HyperTrack::Customer object" do

        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Customer::API_BASE_PATH}#{@customer_params[:id]}/").
          with({ headers: @request_headers }).
          to_return({ body: @response_customer_hash.to_json, status: 200 })

        customer_object = HyperTrack::Customer.retrieve(@customer_params[:id])

        expect(customer_object).to be_an_instance_of HyperTrack::Customer
        expect(customer_object.id).to eq(@customer_params[:id])
        expect(customer_object.name).to eq(@customer_params[:name])
      end
    end

    context ".list with valid args" do
      it "should return an array os HyperTrack::Customer object(s)" do
        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Customer::API_BASE_PATH}").
          with({ headers: @request_headers }).
          to_return({ body: { count: 1, results: [@response_customer_hash] }.to_json, status: 200 })

        customer_list = HyperTrack::Customer.list

        expect(customer_list['count']).to eq(1)
        expect(customer_list['results'][0]).to be_an_instance_of HyperTrack::Customer
        expect(customer_list['results'][0].id).to eq(@customer_params[:id])
        expect(customer_list['results'][0].name).to eq(@customer_params[:name])
      end
    end
  end

end
