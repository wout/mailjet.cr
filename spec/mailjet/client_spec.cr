require "../spec_helper.cr"

describe Mailjet::Client do
  describe "#initialize" do
    it "requires at lease a path" do
      configure_global_api_credentials
      client = Mailjet::Client.new("path", %w[GET])
      client.path.should eq("path")
    end

    it "accepts api credentials" do
      client = Mailjet::Client.new("end_point", %w[GET], "my_key", "my_secret")
      client.api_key.should eq("my_key")
      client.secret_key.should eq("my_secret")
    end

    it "falls back to global credentials" do
      configure_global_api_credentials
      client = Mailjet::Client.new("end_point", %w[GET])
      client.api_key.should eq("global_key")
      client.secret_key.should eq("global_secret")
    end

    it "fails without api credentials" do
      expect_raises(Mailjet::MissingApiCredentialsException) do
        Mailjet::Client.new("path", %w[GET])
      end
    end
  end

  describe "#get" do
    it "fetches a resource" do
      configure_global_api_credentials
      WebMock.stub(:get, "https://api.mailjet.com/send")
        .with(headers: headers_with_basic_auth)
        .to_return(status: 200, body: "{}")

      test_client.get
    end
  end

  describe "#post" do
    it "creates a resource" do
      configure_global_api_credentials
      WebMock.stub(:post, "https://api.mailjet.com/send")
        .with(headers: headers_with_basic_auth)
        .to_return(status: 200, body: "{}")

      test_client.post({id: "65423"})
    end
  end

  describe "#put" do
    it "updates a resource" do
      configure_global_api_credentials
      WebMock.stub(:put, "https://api.mailjet.com/send")
        .with(headers: headers_with_basic_auth)
        .to_return(status: 200, body: "{}")

      test_client.put({id: "65423"})
    end
  end

  describe "#delete" do
    it "deletes a resource" do
      configure_global_api_credentials
      WebMock.stub(:delete, "https://api.mailjet.com/send")
        .with(headers: headers_with_basic_auth)
        .to_return(status: 200, body: "{}")

      test_client.delete({id: "65423"})
    end
  end
end

private def test_client
  Mailjet::Client.new("send", %w[GET POST PUT DELETE])
end

private def headers_with_basic_auth
  {
    "Accept"          => "application/json",
    "Content-Type"    => "application/json",
    "Accept-Encoding" => "deflate",
    "Host"            => "api.mailjet.com",
    "Authorization"   => "Basic Z2xvYmFsX2tleTpnbG9iYWxfc2VjcmV0",
    "User-Agent"      => "mailjet-api-v3-crystal/#{Mailjet::VERSION}",
  }
end
