require "hypertrack"
require "spec_helper"

describe HyperTrack::SharedResource do

  before(:each) do
    @object_params = { id: "my-id", k1: :v1, k2: :v2 }
    @object = HyperTrack::SharedResource.new(@object_params[:id], @object_params)
  end

  context "#[]" do
    it "should return proper value for the key passed" do
      expect(@object[:k1]).to eq(@object_params[:k1])
      expect(@object[:k2]).to eq(@object_params[:k2])
      expect(@object['k1']).to eq(@object_params[:k1])
      expect(@object['k2']).to eq(@object_params[:k2])
      expect(@object[:k3]).to be_nil
    end
  end

  context "#[]=" do
    it "should update values in the object" do
      @object[:k1] = :vv1
      @object['k2'] = 'vv2'

      expect(@object[:k1]).to eq(:vv1)
      expect(@object[:k2]).to eq('vv2')
      expect(@object['k1']).to eq(:vv1)
      expect(@object['k2']).to eq('vv2')
      expect(@object[:k3]).to be_nil
    end
  end

  context "#keys" do
    it "should return an array of keys in the object" do
      expect(@object.keys).to eq(@object_params.keys)
    end
  end

  context "#values" do
    it "should return an array of values in the object" do
      expect(@object.values).to eq(@object_params.values)
    end
  end

  context "#to_json" do
    it "should return all the key-value pair in the object as json" do
      expect(@object.to_json).to eq(@object_params.to_json)
    end
  end

  context "random method (not ending with '=') call on the object" do
    it "should return value of the key (if present) in the object" do
      expect(@object.k1).to eq(@object_params[:k1])
      expect(@object.k2).to eq(@object_params[:k2])

      expect { @object.k3 }.
      to raise_error(NoMethodError)
    end
  end

  context "random method (ending with '=') call on the object" do
    it "should update value of the key (if present) in the object" do
      @object.k1 = :vv1
      @object.k2 = 'vv2'

      expect(@object.k1).to eq(:vv1)
      expect(@object.k2).to eq('vv2')

      expect { @object.k3 = 'v3' }.
      to raise_error(ArgumentError)
    end
  end

end
