require "hypertrack"
require "spec_helper"

describe HyperTrack::Neighbourhood do

  describe ".create with or without args" do
    context "given blank string as args" do
      it "should raise MethodNotAllowed error" do
        expect { HyperTrack::Neighbourhood.create({}) }.
        to raise_error(HyperTrack::MethodNotAllowed, "Create not allowed on HyperTrack::Neighbourhood class")

        expect { HyperTrack::Neighbourhood.create('') }.
        to raise_error(HyperTrack::MethodNotAllowed, "Create not allowed on HyperTrack::Neighbourhood class")

        expect { HyperTrack::Neighbourhood.create() }.
        to raise_error(HyperTrack::MethodNotAllowed, "Create not allowed on HyperTrack::Neighbourhood class")
      end
    end
  end

  describe ".retrieve with invalid args" do
    context "given blank string or nil as neighbourhood_id" do
      it "should raise InvalidParameters error" do
        expect { HyperTrack::Neighbourhood.retrieve('') }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Neighbourhood")

        expect { HyperTrack::Neighbourhood.retrieve(nil) }.
        to raise_error(HyperTrack::InvalidParameters, "ID is required to retrieve a HyperTrack::Neighbourhood")
      end
    end
  end

  describe "HyperTrack::Neighbourhood methods with valid args should return proper values" do

    before(:all) do
      HyperTrack.secret_key = "abc"

      @neighbourhood_params = { id: "unique_neighbourhood_id" }

      @request_headers = {
        Accept: '*/*',
        'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        Authorization: "token #{HyperTrack.secret_key}",
        'Content-Type': 'application/json',
        'User-Agent': 'Ruby'
      }

      @response_neighbourhood_hash = {
        id: "unique_neighbourhood_id",
        name: "Kalkare Extension",
        city: "Bengaluru",
        state: "KA",
        country: "IN",
        polygon: {
          type: "Polygon",
          coordinates: [
            [
              [
                77.66369290000002,
                13.0160065
              ],
              [
                77.66369290000002,
                13.0161065
              ],
              [
                77.66379290000002,
                13.0161065
              ],
              [
                77.66379290000002,
                13.0160065
              ],
              [
                77.66369290000002,
                13.0160065
              ]
            ]
          ]
        },
        created_at: "2016-05-20T09:36:13.868940Z",
        modified_at: "2016-05-20T09:36:13.868996Z"
      }
    end

    context ".retrieve with valid args" do
      it "should return a HyperTrack::Neighbourhood object" do

        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Neighbourhood::API_BASE_PATH}#{@neighbourhood_params[:id]}/").
          with({ headers: @request_headers }).
          to_return({ body: @response_neighbourhood_hash.to_json, status: 200 })

        neighbourhood_object = HyperTrack::Neighbourhood.retrieve(@neighbourhood_params[:id])

        expect(neighbourhood_object).to be_an_instance_of HyperTrack::Neighbourhood
        expect(neighbourhood_object.id).to eq(@neighbourhood_params[:id])
      end
    end

    context ".list with valid args" do
      it "should return an array os HyperTrack::Neighbourhood object(s)" do
        stub_request(:get, "#{HyperTrack::ApiClient::BASE_URL}/#{HyperTrack::ApiClient::API_VERSION}/#{HyperTrack::Neighbourhood::API_BASE_PATH}").
          with({ headers: @request_headers }).
          to_return({ body: { count: 1, results: [@response_neighbourhood_hash] }.to_json, status: 200 })

        neighbourhood_list = HyperTrack::Neighbourhood.list

        expect(neighbourhood_list['count']).to eq(1)
        expect(neighbourhood_list['results'][0]).to be_an_instance_of HyperTrack::Neighbourhood
        expect(neighbourhood_list['results'][0].id).to eq(@neighbourhood_params[:id])
      end
    end
  end

end
