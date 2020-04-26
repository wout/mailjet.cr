require "./spec_helper"

describe Mailjet do
  describe ".configure" do
    it "changes global the confguration" do
      Mailjet.configure do |config|
        config.api_key = "my_key"
        config.secret_key = "super_secret"
        config.api_version = "v3"
        config.default_from = "someone@mailjet.com"
      end

      Mailjet::Config.api_key.should eq("my_key")
      Mailjet::Config.secret_key.should eq("super_secret")
      Mailjet::Config.api_version.should eq("v3")
      Mailjet::Config.default_from.should eq("someone@mailjet.com")
    end
  end
end
