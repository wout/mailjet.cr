require "../../spec_helper.cr"

describe Mailjet::DNS do
  describe ".resource_path" do
    it "returns the resource path" do
      Mailjet::DNS.resource_path.should eq("REST/dns")
    end
  end

  describe ".public_operations" do
    it "returns the allowed methods" do
      Mailjet::DNS.public_operations.should eq(%w[GET])
    end
  end
end
