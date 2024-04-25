require "./spec_helper"

describe Mailjet do
  describe ".configure" do
    it "changes global the confguration" do
      Mailjet.configure do |setting|
        setting.api_key = "my_key"
        setting.secret_key = "super_secret"
        setting.api_version = Mailjet::Api::V3_1
        setting.default_from = "someone@mailjet.com"
      end

      Mailjet.settings.api_key.should eq("my_key")
      Mailjet.settings.secret_key.should eq("super_secret")
      Mailjet.settings.api_version.to_s.should eq("v3.1")
      Mailjet.settings.default_from.should eq("someone@mailjet.com")
    end

    it "validates the default from email" do
      expect_raises(Habitat::InvalidSettingFormatError) do
        Mailjet.configure do |setting|
          setting.default_from = "bla"
        end
      end
    end
  end
end
