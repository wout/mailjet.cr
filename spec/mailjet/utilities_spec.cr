require "../spec_helper"

describe Mailjet::Utilities do
  describe ".to_stringified_hash" do
    it "converts a named tuple to a hash" do
      hash = Mailjet::Utilities.to_stringified_hash({"test": 123})
      hash.should be_a(Hash(String, String))
    end

    it "converts symbol keys to string keys" do
      hash = Mailjet::Utilities.to_stringified_hash({:test => 123})
      hash[:test]?.should be_nil
      hash["test"]?.should eq("123")
    end
  end

  describe ".query_parameterize" do
    it "converts named tuples and hashes to query params" do
      q = Mailjet::Utilities.query_parameterize({test: 123, cool: true})
      q.should eq("Test=123&Cool=true")
      q = Mailjet::Utilities.query_parameterize({:test => 123, :cool => true})
      q.should eq("Test=123&Cool=true")
    end

    it "converts underscored keys to camelcase" do
      q = Mailjet::Utilities.query_parameterize({sum_ting_gut: "wong"})
      q.should eq("SumTingGut=wong")
    end
  end
end
