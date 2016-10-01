require 'hypertrack'

describe Util do

  describe ".symbolize_keys" do
    context "given hash with string keys as argument" do
      it "should return hash with symbolized keys" do
        expect(Util.symbolize_keys({ 'k1' => 'v1', 'k2' => 'v2' })).to eq({ k1: 'v1', k2: 'v2' })
      end
    end

    context "given nested hash with string keys as argument" do
      it "should symbolize keys by one level in the Hash" do
        expect(Util.symbolize_keys({ 'k1' => 'v1', 'k2' => { 'kk1' => 'vv1' } })).to eq({ k1: 'v1', k2: { 'kk1' => 'vv1' } })
      end
    end
  end

  describe ".blank?" do
    context "given nil as argument" do
      it "returns true" do
        expect(Util.blank?(nil)).to eq(true)
      end
    end

    context "given blank('') string as argument" do
      it "returns true" do
        expect(Util.blank?("")).to eq(true)
      end
    end

    context "given non-blank strings and hash/arrays (empty or non-empty) as argument" do
      it "should return false" do
        expect(Util.blank?(" ")).to eq(false)
        expect(Util.blank?("random")).to eq(false)
        expect(Util.blank?([])).to eq(false)
        expect(Util.blank?([1])).to eq(false)
        expect(Util.blank?({})).to eq(false)
        expect(Util.blank?({ a: 1 })).to eq(false)
      end
    end
  end
end
