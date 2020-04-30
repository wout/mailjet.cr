require "../spec_helper"

describe Mailjet::Utilities do
  describe ".normalize_hash" do
    it "converts a named tuple to a hash" do
      hash = Mailjet::Utilities.normalize_hash({"test": 123})
      hash.should be_a(Hash(String, Int32))
    end

    it "converts symbol keys to string keys" do
      hash = Mailjet::Utilities.normalize_hash({:test => 123})
      hash[:test]?.should be_nil
      hash["test"]?.should eq(123)
    end
  end
end
