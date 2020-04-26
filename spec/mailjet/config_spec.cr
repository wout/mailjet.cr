require "../spec_helper.cr"

describe Mailjet::Config do
  describe ".api_version" do
    it "has a default value" do
      Mailjet::Config.api_version.should eq("v3")
    end
  end

  describe ".end_point" do
    it "has a default value" do
      Mailjet::Config.end_point.should eq("https://api.mailjet.com")
    end
  end

  describe ".sandbox_mode" do
    it "has a default value" do
      Mailjet::Config.sandbox_mode.should be_false
    end
  end

  describe ".api_key" do
    it "has no default value" do
      Mailjet::Config.api_key.should be_nil
    end

    it "memorizes the api key" do
      Mailjet::Config.api_key = "my_key"
      Mailjet::Config.api_key.should eq("my_key")
    end
  end

  describe ".secret_key" do
    it "has no default value" do
      Mailjet::Config.secret_key.should be_nil
    end

    it "memorizes the secret key" do
      Mailjet::Config.secret_key = "my_secret"
      Mailjet::Config.secret_key.should eq("my_secret")
    end
  end

  describe ".default_from" do
    it "has no default value" do
      Mailjet::Config.default_from.should be_nil
    end

    it "memorizes the default sender email address" do
      Mailjet::Config.default_from = "me@mailjet.com"
      Mailjet::Config.default_from.should eq("me@mailjet.com")
    end

    it "does a very basic validation of the given email address" do
      expect_raises(Mailjet::InvalidEmailAddressException) do
        Mailjet::Config.default_from = "a@b"
      end
    end
  end

  describe ".open_timeout" do
    it "has a default value" do
      Mailjet::Config.open_timeout.should eq(60)
    end
  end

  describe ".read_timeout" do
    it "has a default value" do
      Mailjet::Config.read_timeout.should eq(60)
    end
  end
end
